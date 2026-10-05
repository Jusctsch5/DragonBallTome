"""Pull skill, ability, and school tables out of the ToME 3 sources."""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
DBT = ROOT / "DBT"
OUT = ROOT / "te4" / "dbt" / "data"

NAMES = {
    "KARATE": "Karate",
    "KICKBOXING": "Kickboxing",
    "KUNGFU": "Kung fu",
    "FENCING": "Fencing",
    "TAEKWONDO": "Tae Kwon Do",
    "NINJUTSU": "Ninjutsu",
    "BALLET": "Ballet",
    "SUMO": "Sumo",
    "JUDO": "Judo",
    "MARKSMANSHIP": "Firing Range",
    "TONY": "Robbins Foundation",
    "TOFU": "Acupuncture Clinic",
    "YMCA": "Y.M.C.A",
    "FLIGHT_SCHOOL": "Flight School",
    "ENROLL_ROSSHI": "Rosshi",
    "ENROLL_CRANE_HERMIT": "Tsuru Sen'Nin",
    "ENROLL_ABBOT": "Abbot",
    "ENROLL_KARIN": "Karin",
    "ENROLL_MUSASHI": "Miyamoto Musashi",
    "ENROLL_POPO": "Mr. Popo",
    "ENROLL_KAMI": "Kami",
    "ENROLL_NORTH_KAIO": "The North Kaio",
    "ENROLL_TRUNKS": "Trunks",
    "ENROLL_SPLINTER": "Splinter",
    "ENROLL_SHREDDER": "Oroku Saki",
    "ENROLL_BRIEFS_SOME": "Dr Briefs",
    "ENROLL_BRIEFS_ALL": "Dr Briefs",
    "ENROLL_MONK": "Buddhist Monk",
}

STORE_SCHOOL = {
    "KARATE": "KARATE",
    "KICKBOXING": "KICKBOXING",
    "KUNGFU": "KUNGFU",
    "FENCING": "FENCING",
    "TAEKWONDO": "TAEKWONDO",
    "NINJUTSU": "NINJUTSU",
    "BALLET": "BALLET",
    "SUMO": "SUMO",
    "JUDO": "JUDO",
    "SHOOTING_RANGE": "MARKSMANSHIP",
    "ACUPUNCTURE": "TOFU",
}


def strip_comments(src):
    out = []
    i = 0
    n = len(src)
    while i < n:
        if src.startswith("--[[", i):
            j = src.find("]]", i + 4)
            i = n if j < 0 else j + 2
            continue
        if src.startswith("--", i):
            j = src.find("\n", i)
            i = n if j < 0 else j
            continue
        if src[i] in "\"'":
            q = src[i]
            out.append(q)
            i += 1
            while i < n:
                if src[i] == "\\" and i + 1 < n:
                    out.append(src[i:i + 2])
                    i += 2
                    continue
                out.append(src[i])
                if src[i] == q:
                    i += 1
                    break
                i += 1
            continue
        out.append(src[i])
        i += 1
    return "".join(out)


def brace_block(text, start):
    depth = 0
    i = start
    while i < len(text):
        c = text[i]
        if c in "\"'":
            q = c
            i += 1
            while i < len(text):
                if text[i] == "\\" and i + 1 < len(text):
                    i += 2
                    continue
                if text[i] == q:
                    i += 1
                    break
                i += 1
            continue
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return text[start:i + 1], i + 1
        i += 1
    raise ValueError("unclosed brace")


def lua_str(s):
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n") + '"'


def field(block, name):
    m = re.search(r'\["%s"\]\s*=\s*' % name, block)
    return m


def string_field(block, name):
    m = field(block, name)
    if not m:
        return ""
    rest = block[m.end():]
    if rest[0] not in "\"'":
        return ""
    q = rest[0]
    i = 1
    chars = []
    while i < len(rest):
        if rest[i] == "\\" and i + 1 < len(rest):
            chars.append(rest[i + 1])
            i += 2
            continue
        if rest[i] == q:
            break
        chars.append(rest[i])
        i += 1
    return "".join(chars)


def number_field(block, name):
    m = re.search(r'\["%s"\]\s*=\s*(-?\d+)' % name, block)
    return int(m.group(1)) if m else 0


def ident_field(block, name):
    m = re.search(r'\["%s"\]\s*=\s*([A-Z0-9_]+)' % name, block)
    return m.group(1) if m else ""


def short_id(token):
    for prefix in ("SKILL_", "AB_", "FLAG_SS_", "FLAG_"):
        if token.startswith(prefix):
            return token[len(prefix):].lower()
    return token.lower()


def function_body(text, start):
    """Return the source of a Lua function beginning at `function`."""
    i = text.find(")", start)
    if i < 0:
        raise ValueError("function has no signature")
    i += 1
    depth = 1
    while i < len(text):
        if text[i] in "\"'":
            q = text[i]
            i += 1
            while i < len(text):
                if text[i] == "\\" and i + 1 < len(text):
                    i += 2
                    continue
                if text[i] == q:
                    i += 1
                    break
                i += 1
            continue
        if text.startswith("function", i) and (i == 0 or not (text[i - 1].isalnum() or text[i - 1] == "_")):
            depth += 1
            i += 8
            continue
        if text.startswith("end", i) and (i == 0 or not (text[i - 1].isalnum() or text[i - 1] == "_")):
            after = i + 3
            if after >= len(text) or not (text[after].isalnum() or text[after] == "_"):
                depth -= 1
                if depth == 0:
                    return text[start:after]
                i = after
                continue
        i += 1
    raise ValueError("unclosed function")


def parse_req(block):
    m = re.search(r'\["reqfct"\]\s*=\s*function\s*\(\s*\)', block)
    if not m:
        return [], "missing reqfct"
    body = function_body(block, block.find("function", m.start()))
    inner = body[body.find(")") + 1:]
    inner = inner[:inner.rfind("end")]
    if re.search(r"\bor\b", inner):
        return [], "req uses or: " + " ".join(inner.split())
    conds = []
    for school, n in re.findall(r"enrollments\[FLAG_(\w+)\]\s*>=\s*(\d+)", inner):
        conds.append({"kind": "enroll", "school": school, "n": int(n)})
    for skill, n in re.findall(r"skill\(SKILL_(\w+)\)\.value\s*>=\s*(\d+)", inner):
        conds.append({"kind": "skill", "skill": skill.lower(), "n": int(n)})
    for n in re.findall(r"player\.lev\s*>=\s*(\d+)", inner):
        conds.append({"kind": "level", "n": int(n)})
    for stat, n in re.findall(r"player\.stat\(A_(\w+)\)\s*>=\s*(\d+)", inner):
        conds.append({"kind": "stat", "stat": stat.lower(), "n": int(n)})
    for ab in re.findall(r"has_ability\(AB_(\w+)\)", inner):
        conds.append({"kind": "ability", "ability": ab.lower()})
    leftover = inner
    for pat in (
        r"enrollments\[FLAG_\w+\]\s*>=\s*\d+",
        r"skill\(SKILL_\w+\)\.value\s*>=\s*\d+",
        r"player\.lev\s*>=\s*\d+",
        r"player\.stat\(A_\w+\)\s*>=\s*\d+",
        r"has_ability\(AB_\w+\)",
        r"return\s+true",
        r"return\s+false",
        r"\bif\b",
        r"\bthen\b",
        r"\belse\b",
        r"\bend\b",
        r"\band\b",
    ):
        leftover = re.sub(pat, " ", leftover)
    leftover = re.sub(r"[\s()]+", "", leftover)
    warn = ""
    if leftover:
        warn = "unparsed req: " + " ".join(inner.split())[:160]
    return conds, warn


def parse_cap(block):
    m = re.search(r'\["cap"\]\s*=\s*function\s*\(\s*\)', block)
    if not m:
        return 0, "missing cap"
    body = function_body(block, block.find("function", m.start()))
    nums = re.findall(r"return\s+(\d+)", body)
    if not nums:
        return 0, "cap has no plain return: " + " ".join(body.split())[:120]
    return int(nums[0]), ""


def parse_desc(block):
    m = re.search(r"\bdesc\s*=\s*", block)
    if not m:
        return ""
    rest = block[m.end():].lstrip()
    if rest.startswith("{"):
        body, _ = brace_block(rest, 0)
        parts = re.findall(r'"((?:\\.|[^"\\])*)"', body)
        return " ".join(p.replace("\\n", " ").replace('\\"', '"') for p in parts)
    if rest[0] in "\"'":
        q = rest[0]
        i = 1
        chars = []
        while i < len(rest):
            if rest[i] == "\\" and i + 1 < len(rest):
                chars.append(rest[i + 1])
                i += 2
                continue
            if rest[i] == q:
                break
            chars.append(rest[i])
            i += 1
        return "".join(chars)
    return ""


def parse_catalog(path, opener):
    text = strip_comments(path.read_text(encoding="utf-8", errors="replace"))
    rows = []
    i = 0
    while True:
        j = text.find(opener, i)
        if j < 0:
            break
        start = text.find("{", j)
        block, i = brace_block(text, start)
        define = re.search(r'define_as\s*=\s*"([A-Z0-9_]+)"', block)
        name = re.search(r'\bname\s*=\s*"([^"]*)"', block)
        if not define or not name or not name.group(1).strip():
            continue
        rows.append((short_id(define.group(1)), name.group(1), parse_desc(block)))
    return rows


def parse_schools(path):
    text = strip_comments(path.read_text(encoding="utf-8", errors="replace"))
    start = text.find("function dball.get_school_definition")
    nxt = text.find("\nfunction ", start + 10)
    body = text[start:nxt if nxt > 0 else len(text)]
    marks = list(re.finditer(r"which == FLAG_(\w+)", body))
    schools = []
    warnings = []
    for idx, mark in enumerate(marks):
        sid = mark.group(1)
        chunk = body[mark.end(): marks[idx + 1].start() if idx + 1 < len(marks) else len(body)]
        cost_m = re.search(r"zeni_cost\s*=\s*(\d+)", chunk)
        cost = int(cost_m.group(1)) if cost_m else 0
        classes = []
        for cm in re.finditer(r"school_data\[\d+\]\s*=", chunk):
            brace = chunk.find("{", cm.end())
            block, _ = brace_block(chunk, brace)
            kind = short_id(ident_field(block, "type"))
            skill = short_id(ident_field(block, "skill"))
            cap, cap_warn = parse_cap(block)
            req, req_warn = parse_req(block)
            if cap_warn:
                warnings.append("%s %s: %s" % (sid, skill, cap_warn))
            if req_warn:
                warnings.append("%s %s: %s" % (sid, skill, req_warn))
            classes.append({
                "type": kind,
                "skill": skill,
                "gain": number_field(block, "gain"),
                "skcost": number_field(block, "skcost"),
                "cap": cap,
                "key": string_field(block, "key"),
                "reqtxt": string_field(block, "reqtxt").strip(),
                "req": req,
            })
        if classes:
            schools.append((sid, cost, classes))
    return schools, warnings


def emit_req(req):
    parts = []
    for c in req:
        if c["kind"] == "enroll":
            parts.append('{kind="enroll", school=%s, n=%d}' % (lua_str(c["school"]), c["n"]))
        elif c["kind"] == "skill":
            parts.append('{kind="skill", skill=%s, n=%d}' % (lua_str(c["skill"]), c["n"]))
        elif c["kind"] == "level":
            parts.append('{kind="level", n=%d}' % c["n"])
        elif c["kind"] == "stat":
            parts.append('{kind="stat", stat=%s, n=%d}' % (lua_str(c["stat"]), c["n"]))
        elif c["kind"] == "ability":
            parts.append('{kind="ability", ability=%s}' % lua_str(c["ability"]))
    return "{" + ", ".join(parts) + "}"


def main():
    skills = parse_catalog(DBT / "data" / "player" / "skills.lua", "new_skill")
    abilities = parse_catalog(DBT / "data" / "player" / "abilities.lua", "new_ability")
    schools, warnings = parse_schools(DBT / "scripts" / "enroll.lua")

    skill_lines = ["-- Generated by te4/tools/extract_skills.py. Do not edit by hand.", "dbt_skills = {"]
    for sid, name, desc in skills:
        skill_lines.append("\t{id=%s, name=%s, desc=%s}," % (lua_str(sid), lua_str(name), lua_str(desc)))
    skill_lines.append("}")
    skill_lines.append("dbt_abilities = {")
    for sid, name, desc in abilities:
        skill_lines.append("\t{id=%s, name=%s, desc=%s}," % (lua_str(sid), lua_str(name), lua_str(desc)))
    skill_lines.append("}")
    (OUT / "skills.lua").write_text("\n".join(skill_lines) + "\n", encoding="utf-8")

    school_lines = ["-- Generated by te4/tools/extract_skills.py. Do not edit by hand.", "dbt_schools = {"]
    for sid, cost, classes in schools:
        school_lines.append("\t%s = {" % sid)
        school_lines.append("\t\tname = %s," % lua_str(NAMES.get(sid, sid)))
        school_lines.append("\t\tcost = %d," % cost)
        school_lines.append("\t\tclasses = {")
        for c in classes:
            school_lines.append(
                "\t\t\t{type=%s, skill=%s, gain=%d, skcost=%d, cap=%d, key=%s, reqtxt=%s, req=%s},"
                % (lua_str(c["type"]), lua_str(c["skill"]), c["gain"], c["skcost"], c["cap"],
                   lua_str(c["key"]), lua_str(c["reqtxt"]), emit_req(c["req"]))
            )
        school_lines.append("\t\t},")
        school_lines.append("\t},")
    school_lines.append("}")
    school_lines.append("dbt_store_school = {")
    for store, school in STORE_SCHOOL.items():
        school_lines.append("\t%s = %s," % (store, lua_str(school)))
    school_lines.append("}")
    (OUT / "schools.lua").write_text("\n".join(school_lines) + "\n", encoding="utf-8")

    print("skills", len(skills), "abilities", len(abilities), "schools", len(schools))
    for sid, cost, classes in schools:
        print(" ", sid, cost, len(classes))
    for w in warnings:
        print("WARN", w)


if __name__ == "__main__":
    main()

# Pull quest text and NPC talks out of the ToME 3 scripts.
# Quest catalog: te4/dbt/data/quests.lua
# One chat per dialogue function: te4/dbt/data/chats/g_<name>.lua
# Race -> chat: te4/dbt/data/talks.lua
import os
import re
import shutil

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
DBT = os.path.join(ROOT, "DBT", "scripts")
OUT = os.path.join(ROOT, "te4", "dbt", "data")
CHAT_DIR = os.path.join(OUT, "chats")

ID_ALIAS = {
    "DOJO": "choose_style",
    "TOURNAMENT": "tournament",
    "SAVE_THE_TEMPLE": "temple",
    "WHITE_WOLF": "white_wolf",
    "TENTACLE_DEMON": "tentacle_demon",
    "ROSSHI_LONELY": "rosshi_lonely",
}
STATUS = {
    "UNTAKEN": "untaken",
    "TAKEN": "taken",
    "COMPLETED": "completed",
    "FINISHED": "finished",
    "FAILED": "failed",
}
SKIP_FUNCS = {
    "DTEST", "ROSSHI", "CRANE_HERMIT", "MUSASHI", "KRILLAN", "ABBOT",
    "URANAI_BABA", "SPLINTER", "SAMPLE",
}
HAND_RACE = {
    "RACE_ROSSHI": "rosshi",
    "RACE_CRANE_HERMIT": "crane",
    "RACE_MUSASHI": "musashi",
    "RACE_KRILLAN": "krillin",
    "RACE_ABBOT": "abbot",
    "RACE_SPLINTER": "splinter",
    "RACE_WT_TICKET_GIRL": "wt-ticket",
    "RACE_WT_GUARD": "wt-guard",
    "RACE_WT_BACKSTAGE_GUY": "wt-backstage",
    "RACE_WT_MEDIC": "wt-medic",
    "RACE_WT_AUDIENCE_BLUE": "wt-audience",
    "RACE_WT_AUDIENCE_GREEN": "wt-audience",
    "RACE_WT_AUDIENCE_YELLOW": "wt-audience",
}
FUNC_RACE = {
    "KAIO": "RACE_NORTH_KAIO",
    "POPO": "RACE_MR_POPO",
    "GERO": "RACE_DR_GERO",
    "SATAN": "RACE_MR_SATAN",
    "OXKING": "RACE_OXKING",
    "OX_KING": "RACE_OXKING",
    "CHICHI": "RACE_CHICHI",
    "CHI_CHI": "RACE_CHICHI",
    "EMMA": "RACE_EMMA_DAIO",
    "RED": "RACE_RRA_RED",
    "BLUE": "RACE_RRA_BLUE",
    "ANDROID8": "RACE_ANDROID8",
    "ANDROID_8": "RACE_ANDROID8",
    "MR_POPO": "RACE_MR_POPO",
    "NORTH_KAIO": "RACE_NORTH_KAIO",
    "DR_GERO": "RACE_DR_GERO",
    "MR_SATAN": "RACE_MR_SATAN",
    "KARATE": "RACE_NAKAMURA",
    "KICKBOXING": "RACE_BOB",
    "KUNGFU": "RACE_FONG_SAI_YUK",
    "FENCING": "RACE_JACQUE",
    "SUMO": "RACE_HONDA",
    "JUDO": "RACE_YAWARA",
    "TAEKWONDO": "RACE_MASTER_LEE",
    "NINJUTSU": "RACE_HATSUMI",
    "NAMEK_ELDER": "RACE_NAMEK_ELDER1",
    "MONK_ONE": "RACE_BUDDHIST_MONK",
    "MONK_TWO": "RACE_MEDITATING_MONK",
    "EVIL_MONK": "RACE_CORRUPT_MONK_A",
    "SHENRON": "RACE_SHENRON",
}


def lua_long(s):
    eq = "="
    while ("]" + eq + "]") in s:
        eq += "="
    return "[" + eq + "[" + s + "]" + eq + "]"


def pieces_to_lua(pieces):
    parts = []
    for kind, val in pieces:
        if kind == "name":
            parts.append('(player.name or "you")')
        elif val:
            parts.append(lua_long(val))
    return " .. ".join(parts) if parts else None


def read_lua_string(src, i):
    q = src[i]
    i += 1
    out = []
    while i < len(src):
        c = src[i]
        if c == "\\":
            nxt = src[i + 1] if i + 1 < len(src) else ""
            mapping = {"n": "\n", "t": "\t", "\\": "\\", '"': '"', "'": "'"}
            out.append(mapping.get(nxt, nxt))
            i += 2
            continue
        if c == q:
            return "".join(out), i + 1
        out.append(c)
        i += 1
    return "".join(out), i


def expr_pieces(expr):
    expr = re.sub(r"player_name\s*\(\s*\)", "player_name()", expr)
    pieces = []
    i = 0
    buf = []

    def flush():
        if buf:
            pieces.append(("lit", "".join(buf)))
            buf.clear()

    while i < len(expr):
        if expr.startswith("player_name()", i):
            flush()
            pieces.append(("name", None))
            i += len("player_name()")
            continue
        if expr[i] in "\"'":
            flush()
            s, i = read_lua_string(expr, i)
            pieces.append(("lit", s))
            continue
        if expr.startswith("[[", i):
            flush()
            end = expr.find("]]", i + 2)
            if end < 0:
                break
            pieces.append(("lit", expr[i + 2:end]))
            i = end + 2
            continue
        i += 1
    flush()
    # Drop color-only empties. Keep real text.
    return [p for p in pieces if p[0] == "name" or (p[1] and p[1].strip())]


class Screen(object):
    def __init__(self):
        self.texts = []
        self.actions = []
        self.helpers = []
        self.gates = []
        self.branches = {}
        self.returned = False


class Tok(object):
    def __init__(self, kind, val):
        self.kind = kind
        self.val = val


def lex(src):
    toks = []
    i = 0
    n = len(src)
    while i < n:
        c = src[i]
        if c in " \t\r\n":
            i += 1
            continue
        if c == "-" and i + 1 < n and src[i + 1] == "-":
            if src.startswith("--[[", i):
                end = src.find("]]", i + 4)
                i = n if end < 0 else end + 2
            else:
                nl = src.find("\n", i)
                i = n if nl < 0 else nl + 1
            continue
        if c in "\"'":
            s, i = read_lua_string(src, i)
            toks.append(Tok("str", s))
            continue
        if c == "[" and i + 1 < n and src[i + 1] == "[":
            end = src.find("]]", i + 2)
            toks.append(Tok("str", src[i + 2:end] if end >= 0 else ""))
            i = n if end < 0 else end + 2
            continue
        if c.isalpha() or c == "_":
            j = i + 1
            while j < n and (src[j].isalnum() or src[j] == "_"):
                j += 1
            toks.append(Tok("id", src[i:j]))
            i = j
            continue
        if c.isdigit() or (c == "-" and i + 1 < n and src[i + 1].isdigit()):
            j = i + 1
            while j < n and (src[j].isdigit() or src[j] == "."):
                j += 1
            toks.append(Tok("num", src[i:j]))
            i = j
            continue
        if c in "().{},[]=<>~":
            if src.startswith("==", i) or src.startswith("~=", i) or src.startswith("<=", i) or src.startswith(">=", i):
                toks.append(Tok("sym", src[i:i + 2]))
                i += 2
                continue
            if c == "." and i + 1 < n and src[i + 1] == ".":
                toks.append(Tok("sym", ".."))
                i += 2
                continue
            toks.append(Tok("sym", c))
            i += 1
            continue
        toks.append(Tok("sym", c))
        i += 1
    toks.append(Tok("eof", ""))
    return toks


STMT = {
    "if", "elseif", "else", "end", "while", "for", "function", "repeat",
    "return", "local", "until", "do",
}


def quest_id(name):
    return ID_ALIAS.get(name, name.lower())


class Parser(object):
    def __init__(self, src):
        self.toks = lex(src)
        self.i = 0
        self.answer_name = "ans"
        self.failed = []

    def peek(self):
        return self.toks[self.i]

    def pop(self):
        t = self.toks[self.i]
        self.i += 1
        return t

    def skip_balanced(self, open_ch, close_ch):
        # current token is the opener
        self.pop()
        depth = 1
        while depth and self.peek().kind != "eof":
            v = self.peek().val
            if v == open_ch:
                depth += 1
            elif v == close_ch:
                depth -= 1
            self.pop()

    def skip_expr(self):
        depth = 0
        seen = False
        while self.peek().kind != "eof":
            t = self.peek()
            if t.kind == "sym" and t.val in "([{":
                depth += 1
                self.pop()
                seen = True
                continue
            if t.kind == "sym" and t.val in ")]}":
                if depth == 0:
                    return
                depth -= 1
                self.pop()
                seen = True
                continue
            if depth == 0 and seen and (t.val in STMT or (t.kind == "id" and t.val not in ("and", "or", "not"))):
                return
            if depth == 0 and t.val in ("end", "elseif", "else", "until"):
                return
            self.pop()
            seen = True

    def call_args_src(self):
        # current is '('
        start = self.i
        self.skip_balanced("(", ")")
        parts = []
        for t in self.toks[start + 1:self.i - 1]:
            if t.kind == "str":
                parts.append('"' + t.val.replace("\\", "\\\\").replace('"', '\\"').replace("\n", "\\n") + '"')
            else:
                parts.append(t.val if isinstance(t.val, str) else str(t.val))
        return " ".join(parts)

    def translate_cond(self, expr):
        expr = re.sub(r"\s+", " ", expr).strip()
        expr = re.sub(r"\s*\.\s*", ".", expr)
        expr = re.sub(r"\s*\(\s*", "(", expr)
        expr = re.sub(r"\s*\)\s*", ")", expr)
        expr = re.sub(r"\s*\[\s*", "[", expr)
        expr = re.sub(r"\s*\]\s*", "]", expr)
        if not expr or expr == "true":
            return "true"
        if "may_i_party" in expr or "is_partied" in expr or "qty_partied" in expr:
            m = re.search(r"RACE_(\w+)", expr)
            race = ("RACE_" + m.group(1)) if m else None
            if "is_partied" in expr and race:
                return 'player:isPartied("%s")' % race
            if "may_i_party" in expr and race:
                return 'player:mayParty({define_as="%s", level=1, name="them"})' % race
            if "qty_partied" in expr:
                return "player.party and #player.party > 0"
            return "false"
        if "race_info_idx" in expr:
            return "false"
        m = re.search(r"inventory\[(INVEN_\w+)\]\[1\]", expr)
        if m:
            slot = {
                "INVEN_WIELD": "WIELD",
                "INVEN_BODY": "BODY",
                "INVEN_FEET": "FEET",
                "INVEN_TOOL": "TOOL",
                "INVEN_HEAD": "HEAD",
                "INVEN_OUTER": "OUTER",
                "INVEN_HANDS": "HANDS",
                "INVEN_ARMS": "ARMS",
                "INVEN_RING": "RING",
            }.get(m.group(1))
            if slot:
                return '(player:getInven("%s") and player:getInven("%s")[1])' % (slot, slot)
        m = re.match(r"dball_data\.(\w+)\s*(==|~=|<=|>=|<|>)\s*(-?\d+)$", expr)
        if m:
            op = m.group(2)
            return "(player.%s or 0) %s %s" % (m.group(1), op, m.group(3))
        m = re.match(r"quest\(QUEST_(\w+)\)\.status\s*(==|~=)\s*QUEST_STATUS_(\w+)$", expr)
        if m:
            qid = quest_id(m.group(1))
            op = m.group(2)
            st = STATUS.get(m.group(3), m.group(3).lower())
            if st == "untaken" and op == "==":
                return "not (player.quests and player.quests.%s)" % qid
            if st == "untaken" and op == "~=":
                return "player.quests and player.quests.%s" % qid
            cmp = "==" if op == "==" else "~="
            return '(player.quests and player.quests.%s and player.quests.%s.status %s "%s")' % (qid, qid, cmp, st)
        m = re.match(r"enrollments\[FLAG_(?:ENROLL_)?(\w+)\]\s*==\s*0$", expr)
        if m:
            return "not (player.trainers and player.trainers.%s)" % m.group(1)
        m = re.match(r'dball_data\.p_class\s*==\s*"(.*)"$', expr)
        if m:
            return '(player.descriptor and player.descriptor.class == %s)' % lua_long(m.group(1))
        m = re.match(r"enrollments\[FLAG_(?:ENROLL_)?(\w+)\]\s*>\s*(\d+)$", expr)
        if m:
            school = m.group(1)
            if int(m.group(2)) > 0:
                return "false"
            student = {
                "ROSSHI": "player.rosshi_student",
                "CRANE_HERMIT": "player.crane_student",
                "MUSASHI": "player.musashi_student",
                "ABBOT": "player.abbot_student",
            }.get(school, "false")
            return "(%s or (player.trainers and player.trainers.%s))" % (student, school)
        m = re.match(r"player\.get_sex\(\)\s*~=\s*\"Female\"$", expr)
        if m:
            return "not player.female"
        m = re.match(r"player\.get_sex\(\)\s*~=\s*\"Male\"$", expr)
        if m:
            return "player.female"
        m = re.match(r"dball_data\.(\w+)\s*\+\s*dball_data\.(\w+)\s*==\s*(-?\d+)$", expr)
        if m:
            return "((player.%s or 0) + (player.%s or 0)) == %s" % (m.group(1), m.group(2), m.group(3))
        if re.match(r"dball\.dragonballs_carried\(\)\s*>\s*0$", expr):
            return "(player.dragonballs and next(player.dragonballs) ~= nil)"
        m = re.match(r"player\.get_sex\(\)\s*==\s*\"Female\"$", expr)
        if m:
            return "player.female"
        m = re.match(r"player\.get_sex\(\)\s*==\s*\"Male\"$", expr)
        if m:
            return "not player.female"
        m = re.match(r"dball\.persuade\((\d+)\)$", expr)
        if m:
            return 'player:effStat("chr") >= %s' % m.group(1)
        m = re.match(r"(?:skill\(SKILL_|get_skill\(SKILL_)(\w+)\)(?:\.value)?\s*(==|~=|<=|>=|<|>)\s*(-?\d+)$", expr)
        if m:
            return 'player:skillLevel("%s") %s %s' % (m.group(1).lower(), m.group(2), m.group(3))
        m = re.match(r"player\.au\s*(==|~=|<=|>=|<|>)\s*(-?\d+)$", expr)
        if m:
            return "(player.money or 0) %s %s" % (m.group(1), m.group(2))
        m = re.match(r"dball\.current_location\(\)\s*==\s*\"(.*)\"$", expr)
        if m:
            return "game.zone and game.zone.name == %s" % lua_long(m.group(1))
        if expr.startswith("not "):
            inner = self.translate_cond(expr[4:])
            if inner and inner != "true":
                return "not (" + inner + ")"
            return None
        for sep in (" and ", " or "):
            if sep in expr:
                bits = expr.split(sep)
                out = []
                for b in bits:
                    t = self.translate_cond(b.strip())
                    if not t:
                        return None
                    out.append("(" + t + ")")
                return sep.join(out)
        return None

    def read_cond_until_then(self):
        parts = []
        while self.peek().kind != "eof" and not (self.peek().kind == "id" and self.peek().val == "then"):
            t = self.pop()
            if t.kind == "str":
                parts.append('"' + t.val.replace('"', '\\"') + '"')
            else:
                parts.append(str(t.val))
        if self.peek().val == "then":
            self.pop()
        return " ".join(parts)

    def is_ans_cond(self, expr):
        name = self.answer_name
        return bool(re.search(r"\b%s\s*==\s*\"" % re.escape(name), expr))

    def ans_keys(self, expr):
        name = self.answer_name
        return re.findall(r"%s\s*==\s*\"([^\"]*)\"" % re.escape(name), expr)

    def take_known_call(self, screen):
        t = self.peek()
        if t.kind != "id":
            return False
        if t.val == "message" and self.toks[self.i + 1].val == "(":
            self.pop()
            args = self.call_args_src()
            pcs = expr_pieces(args)
            lua = pieces_to_lua(pcs)
            if lua:
                screen.texts.append(lua)
            return True
        if t.val == "change_quest_status" and self.toks[self.i + 1].val == "(":
            self.pop()
            args = self.call_args_src()
            m = re.search(r"QUEST_(\w+).*QUEST_STATUS_(\w+)", args)
            if m:
                screen.actions.append('player:takeQuest("%s", "%s")' % (quest_id(m.group(1)), STATUS.get(m.group(2), "taken")))
            return True
        if t.val == "acquire_quest" and self.toks[self.i + 1].val == "(":
            self.pop()
            args = self.call_args_src()
            m = re.search(r"QUEST_(\w+)", args)
            if m:
                screen.actions.append('player:takeQuest("%s", "taken")' % quest_id(m.group(1)))
            return True
        if t.val == "term" and self.toks[self.i + 1].val == "." and self.toks[self.i + 2].val == "text_out":
            self.pop(); self.pop(); self.pop()
            if self.peek().val == "(":
                args = self.call_args_src()
                lua = pieces_to_lua(expr_pieces(args))
                if lua:
                    screen.texts.append(lua)
            return True
        if t.val == "dialogue" and self.toks[self.i + 1].val == ".":
            field = self.toks[self.i + 2].val
            if field == "helper":
                self.pop(); self.pop(); self.pop()
                if self.peek().val != "(":
                    return True
                self.pop()
                pieces = []
                depth = 0
                while self.peek().kind != "eof":
                    t = self.peek()
                    if t.val == "(":
                        depth += 1
                        self.pop()
                        continue
                    if t.val == ")" and depth == 0:
                        break
                    if t.val == "," and depth == 0:
                        break
                    if t.val == ")":
                        depth -= 1
                        self.pop()
                        continue
                    if t.kind == "str":
                        pieces.append(("lit", self.pop().val))
                        continue
                    if t.val == "player_name":
                        self.pop()
                        if self.peek().val == "(":
                            self.skip_balanced("(", ")")
                        pieces.append(("name", None))
                        continue
                    self.pop()
                key = "a"
                if self.peek().val == ",":
                    self.pop()
                    if self.peek().kind == "str":
                        key = self.pop().val or "a"
                depth = 1
                while depth and self.peek().kind != "eof":
                    v = self.pop().val
                    if v == "(":
                        depth += 1
                    elif v == ")":
                        depth -= 1
                lua = pieces_to_lua(pieces) or lua_long("...")
                screen.helpers.append((lua, key or "a"))
                return True
            if field == "answer":
                self.pop(); self.pop(); self.pop()
                if self.peek().val == "(":
                    self.skip_balanced("(", ")")
                return True
            if field in ("prep", "conclude", "quickie", "store_hack"):
                self.pop(); self.pop(); self.pop()
                if field == "quickie" and self.peek().val == "(":
                    args = self.call_args_src()
                    lua = pieces_to_lua(expr_pieces(args))
                    if lua:
                        screen.texts.append(lua)
                    screen.returned = True
                elif self.peek().val == "(":
                    self.skip_balanced("(", ")")
                return True
            return False
        if t.val == "dball" and self.toks[self.i + 1].val == "." and self.toks[self.i + 2].val == "enroll":
            self.pop(); self.pop(); self.pop()
            if self.peek().val == "(":
                args = self.call_args_src()
                m = re.search(r"FLAG_ENROLL_(\w+)", args)
                if m:
                    school = m.group(1)
                    screen.actions.append(
                        'player.trainers = player.trainers or {}\n'
                        '\t\tplayer.trainers.%s = true\n'
                        '\t\tif dbt_schools and dbt_schools.%s then\n'
                        '\t\t\tgame:loadTraining()\n'
                        '\t\t\tlocal Trainer = require "mod.dialogs.Trainer"\n'
                        '\t\t\tgame:registerDialog(Trainer.new("%s", player))\n'
                        '\t\tend' % (school, school, school)
                    )
            return True
        if t.val == "dball_data" and self.toks[self.i + 1].val == ".":
            field = self.toks[self.i + 2].val
            if self.toks[self.i + 3].val == "=" and self.toks[self.i + 3].val != "==":
                if self.toks[self.i + 4].kind == "num":
                    self.i += 5
                    screen.actions.append("player.%s = %s" % (field, self.toks[self.i - 1].val))
                    return True
        if t.val == "quest" and self.toks[self.i + 1].val == "(":
            # quest(QUEST_X).status = QUEST_STATUS_Y
            window = " ".join(tok.val if tok.kind != "str" else '"%s"' % tok.val for tok in self.toks[self.i:self.i + 12])
            m = re.search(r"QUEST_(\w+)\s*\)\s*\.\s*status\s*=\s*QUEST_STATUS_(\w+)", window)
            if m:
                # consume tokens through the status token
                while self.peek().kind != "eof" and self.peek().val != m.group(2):
                    self.pop()
                if self.peek().val == m.group(2):
                    self.pop()
                screen.actions.append('player:takeQuest("%s", "%s")' % (quest_id(m.group(1)), STATUS.get(m.group(2), "taken")))
                return True
        if t.val == "party" and self.toks[self.i + 1].val == "." and self.toks[self.i + 2].val in ("party", "unparty"):
            kind = self.toks[self.i + 2].val
            self.pop(); self.pop(); self.pop()
            args = self.call_args_src() if self.peek().val == "(" else ""
            m = re.search(r"RACE_(\w+)", args)
            if kind == "party" and m:
                screen.actions.append(
                    'player:partyWith({define_as="RACE_%s", name="companion", level=1})' % m.group(1)
                )
            elif kind == "unparty" and m:
                screen.actions.append('player:unparty("RACE_%s")' % m.group(1))
            return True
        return False

    def skip_statement(self):
        if self.peek().kind == "eof":
            return
        if self.take_known_call(Screen()):
            return
        t = self.peek()
        if t.kind == "id" and t.val == "local":
            self.pop()
            if self.peek().kind == "id":
                name = self.pop().val
                if self.peek().val == "=":
                    self.pop()
                    if (self.peek().val == "dialogue" and self.toks[self.i + 1].val == "."
                            and self.toks[self.i + 2].val == "answer"):
                        self.answer_name = name
                        self.pop(); self.pop(); self.pop()
                        if self.peek().val == "(":
                            self.skip_balanced("(", ")")
                        return
                    self.skip_expr()
            return
        if t.kind == "id" and t.val == "return":
            self.pop()
            self.skip_expr()
            return
        self.skip_expr()

    def parse_block(self):
        screen = Screen()
        while self.peek().kind != "eof":
            t = self.peek()
            if t.val in ("end", "elseif", "else", "until"):
                return screen
            if t.val == "if":
                self.pop()
                cond = self.read_cond_until_then()
                if self.is_ans_cond(cond):
                    arms = [(self.ans_keys(cond), self.parse_block())]
                    while self.peek().val == "elseif":
                        self.pop()
                        cond = self.read_cond_until_then()
                        if self.is_ans_cond(cond):
                            arms.append((self.ans_keys(cond), self.parse_block()))
                        else:
                            # a non-answer elseif ends the answer chain; treat as a gate on the fallthrough
                            break
                    else_screen = None
                    if self.peek().val == "else":
                        self.pop()
                        else_screen = self.parse_block()
                    if self.peek().val == "end":
                        self.pop()
                    fall = self.parse_block()
                    for keys, sub in arms:
                        graft(sub, fall)
                        for k in keys or ["a"]:
                            screen.branches[k] = sub
                    if else_screen is not None:
                        graft(else_screen, fall)
                        screen.branches.setdefault("_else", else_screen)
                    return screen
                arms = [(cond, self.parse_block(), False)]
                while self.peek().val == "elseif":
                    self.pop()
                    cond = self.read_cond_until_then()
                    arms.append((cond, self.parse_block(), False))
                if self.peek().val == "else":
                    self.pop()
                    arms.append(("true", self.parse_block(), True))
                if self.peek().val == "end":
                    self.pop()
                self.add_gates(screen, arms)
                continue
            if t.val in ("while", "for"):
                self.pop()
                while self.peek().kind != "eof" and self.peek().val != "do":
                    self.pop()
                if self.peek().val == "do":
                    self.pop()
                inner = self.parse_block()
                if self.peek().val == "end":
                    self.pop()
                absorb(screen, inner)
                continue
            if t.val == "function":
                self.pop()
                depth = 1
                while depth and self.peek().kind != "eof":
                    v = self.pop().val
                    if v == "function":
                        depth += 1
                    elif v == "end":
                        depth -= 1
                continue
            if t.val == "repeat":
                self.pop()
                inner = self.parse_block()
                if self.peek().val == "until":
                    self.pop()
                    self.skip_expr()
                absorb(screen, inner)
                continue
            if t.val == "return":
                self.pop()
                self.skip_expr()
                screen.returned = True
                return screen
            if t.val == "do":
                self.pop()
                inner = self.parse_block()
                if self.peek().val == "end":
                    self.pop()
                absorb(screen, inner)
                continue
            if self.take_known_call(screen):
                continue
            before = self.i
            self.skip_statement()
            if self.i == before:
                self.pop()
        return screen

    def add_gates(self, screen, arms):
        translated = []
        for cond, sub, is_else in arms:
            lua = "true" if is_else else self.translate_cond(cond)
            if lua is None:
                self.failed.append(cond)
                absorb(screen, sub)
            else:
                translated.append((lua, sub, is_else))
        known = [c for c, _, is_else in translated if not is_else and c != "true"]
        for lua, sub, is_else in translated:
            if is_else and known:
                lua = "not (" + " or ".join("(" + c + ")" for c in known) + ")"
            screen.gates.append((lua, sub))


def absorb(dst, src):
    dst.texts.extend(src.texts)
    dst.actions.extend(src.actions)
    dst.helpers.extend(src.helpers)
    dst.gates.extend(src.gates)
    for k, sub in src.branches.items():
        dst.branches[k] = sub
    if src.returned:
        dst.returned = True


def graft(dst, fall):
    if dst.returned or fall is None:
        return
    if not fall.texts and not fall.actions and not fall.helpers and not fall.gates and not fall.branches:
        return
    if dst.branches:
        for sub in dst.branches.values():
            graft(sub, fall)
        return
    if dst.gates:
        for _, sub in dst.gates:
            graft(sub, fall)
        return
    dst.texts.extend(fall.texts)
    dst.actions.extend(fall.actions)
    dst.helpers.extend(fall.helpers)
    dst.gates.extend(fall.gates)
    if fall.branches:
        dst.branches = fall.branches


def split_functions(src):
    marks = [(m.start(), m.group(1)) for m in re.finditer(r"(?m)^function dialogue\.(\w+)\s*\(", src)]
    out = []
    for i, (pos, name) in enumerate(marks):
        end = marks[i + 1][0] if i + 1 < len(marks) else len(src)
        body = src[pos:end]
        brace = body.find("\n")
        out.append((name, body[brace + 1:] if brace >= 0 else body))
    return out


def safe_key(key):
    return re.sub(r"[^A-Za-z0-9_]", "_", key) or "x"


def child_id(node_id, gate_index, key):
    if gate_index is None:
        return "%s_%s" % (node_id, safe_key(key))
    return "%s_g%d_%s" % (node_id, gate_index, safe_key(key))


def emit_nodes(screen, node_id, nodes, seq):
    if len(nodes) > 500:
        return
    nodes.append((node_id, screen))
    for key, sub in screen.branches.items():
        emit_nodes(sub, child_id(node_id, None, key), nodes, seq)
    for i, (_, sub) in enumerate(screen.gates):
        for key, bsub in sub.branches.items():
            emit_nodes(bsub, child_id(node_id, i, key), nodes, seq)


def action_block(actions, indent):
    if not actions:
        return ""
    lines = []
    for a in actions:
        for line in a.split("\n"):
            lines.append(indent + line)
    return "\n".join(lines) + "\n"


def emit_chat(name, screen):
    nodes = []
    emit_nodes(screen, "n0", nodes, [0])
    chunks = []
    for node_id, scr in nodes:
        gate_arms = []
        n = 0

        def walk(s, prefix_checks):
            nonlocal n
            if s.gates:
                for cond, sub in s.gates:
                    n += 1
                    arm = "%s.%d" % (prefix_checks, n) if prefix_checks else str(n)
                    gate_arms.append((arm, cond, sub.actions, sub.texts))
                    walk(sub, arm)
            elif prefix_checks == "" and s.texts:
                gate_arms.append(("", "true", s.actions, s.texts))

        # Root texts and actions are the default arm. Gates are alternatives.
        if scr.gates:
            n = 0
            for cond, sub in scr.gates:
                n += 1
                gate_arms.append((str(n), cond, sub.actions, sub.texts or scr.texts))
            if scr.texts:
                gate_arms.append(("", None, scr.actions, scr.texts))
        else:
            gate_arms.append(("", None, scr.actions, scr.texts))

        helpers = []

        def collect_helpers(s, arm):
            for label, key in s.helpers:
                helpers.append((arm, label, key))
            for _, sub in s.gates:
                # helpers live on the gate screen itself; nested gates get their own arm via texts,
                # and their helpers were stored on that screen.
                pass
            if not s.gates:
                return
            # Re-walk to attach helpers to the same arm ids assign above.
        # Assign helpers by repeating the gate walk.
        if scr.gates:
            idx = 0
            for cond, sub in scr.gates:
                idx += 1
                for label, key in sub.helpers:
                    helpers.append((str(idx), label, key, idx - 1))
            for label, key in scr.helpers:
                helpers.append(("", label, key, None))
        else:
            for label, key in scr.helpers:
                helpers.append(("", label, key, None))

        use_fn = bool(scr.gates) or any("player.name" in tx for tx in scr.texts) or any(a for a in scr.actions)
        # also if any gate text references player
        for _, _, _, texts in gate_arms:
            if any("player.name" in (tx or "") for tx in texts):
                use_fn = True
        lines = []
        if scr.gates or scr.actions:
            lines.append("local shown_%s = nil" % node_id)
            lines.append("local function arm_%s(player)" % node_id)
            lines.append("\tif shown_%s ~= nil then return shown_%s end" % (node_id, node_id))
            for arm, cond, actions, texts in gate_arms:
                if arm == "":
                    continue
                lines.append("\tif %s then" % cond)
                lines.append(action_block(actions, "\t\t") + "\t\tshown_%s = %s" % (node_id, lua_long(arm)))
                lines.append("\t\treturn shown_%s" % node_id)
                lines.append("\tend")
            # default
            default_actions = []
            for arm, cond, actions, texts in gate_arms:
                if arm == "":
                    default_actions = actions
            lines.append(action_block(default_actions, "\t") + "\tshown_%s = %s" % (node_id, lua_long("")))
            lines.append("\treturn shown_%s" % node_id)
            lines.append("end")
        head = "\n".join(lines)
        body = []
        body.append('newChat{ id=%s,' % lua_long(node_id))
        if scr.gates or (scr.actions and not scr.texts):
            body.append("\ttext = function(npc, player)")
            body.append("\t\tlocal which = arm_%s(player)" % node_id)
            for arm, cond, actions, texts in gate_arms:
                joined = " .. ".join(texts) if texts else lua_long("...")
                tag = lua_long(arm)
                body.append("\t\tif which == %s then return %s end" % (tag, joined))
            body.append('\t\treturn "..."')
            body.append("\tend,")
        elif use_fn and scr.texts:
            joined = " .. ".join(scr.texts)
            body.append("\ttext = function(npc, player)")
            if scr.actions:
                body.append("\t\tarm_%s(player)" % node_id)
            body.append("\t\treturn " + joined)
            body.append("\tend,")
        elif scr.texts:
            body.append("\ttext = " + " .. ".join(scr.texts) + ",")
        else:
            body.append('\ttext = "...",')
        body.append("\tanswers = {")
        if not helpers:
            if name == "SHENRON" and node_id == "n0":
                body.append('\t\t{"I wish...", action=function(npc, player) player:promptWish() end},')
            body.append('\t\t{"[Leave]"},')
        else:
            seen = set()
            for arm, label, key, gate_index in helpers:
                owner = None
                owner_index = None
                if gate_index is not None and key in scr.gates[gate_index][1].branches:
                    owner = scr.gates[gate_index][1]
                    owner_index = gate_index
                elif key in scr.branches:
                    owner = scr
                    owner_index = None
                jump = child_id(node_id, owner_index, key) if owner is not None else None
                cond = None
                if scr.gates:
                    if arm == "":
                        cond = 'function(npc, player) return arm_%s(player) == "" end' % node_id
                    else:
                        cond = "function(npc, player) return arm_%s(player) == %s end" % (node_id, lua_long(arm))
                entry = "\t\t{%s" % label
                if jump:
                    entry += ", jump=%s" % lua_long(jump)
                dest = owner.branches.get(key) if owner else None
                if dest and dest.actions and not dest.gates:
                    stmt = " ".join(a.replace("\n", " ") for a in dest.actions)
                    entry += ", action=function(npc, player) %s end" % stmt
                if cond:
                    entry += ", cond=%s" % cond
                entry += "},"
                sig = (arm, label, key, jump)
                if sig not in seen:
                    seen.add(sig)
                    body.append(entry)
            if name == "SHENRON" and node_id == "n0":
                body.append('\t\t{"I wish...", action=function(npc, player) player:promptWish() end},')
            body.append('\t\t{"[Leave]"},')
        body.append("\t},")
        body.append("}")
        chunks.append(head + ("\n" if head else "") + "\n".join(body))
    text = "-- dbt-generated-talk dialogue.%s\n-- Do not edit by hand.\n\n" % name
    text += "\n\n".join(chunks)
    text += '\n\nreturn "n0"\n'
    return text


def balance_ok(src):
    i = 0
    n = len(src)
    depth_end = 0
    while i < n:
        if src.startswith("--", i):
            nl = src.find("\n", i)
            i = n if nl < 0 else nl + 1
            continue
        if src[i] in "\"'":
            _, i = read_lua_string(src, i)
            continue
        if src[i] == "[" and i + 1 < n and (src[i + 1] == "[" or src[i + 1] == "="):
            j = i + 1
            while j < n and src[j] == "=":
                j += 1
            if j < n and src[j] == "[":
                eq = src[i + 1:j]
                close = "]" + eq + "]"
                end = src.find(close, j + 1)
                i = n if end < 0 else end + len(close)
                continue
        if src[i].isalpha() or src[i] == "_":
            j = i + 1
            while j < n and (src[j].isalnum() or src[j] == "_"):
                j += 1
            word = src[i:j]
            if word in ("function", "if", "while", "for", "do"):
                depth_end += 1
            elif word == "end":
                depth_end -= 1
            i = j
            continue
        i += 1
    return depth_end == 0


def brace_body(src, i):
    # i points at {
    depth = 0
    start = i
    while i < len(src):
        if src.startswith("--", i):
            nl = src.find("\n", i)
            i = len(src) if nl < 0 else nl + 1
            continue
        if src[i] in "\"'":
            _, i = read_lua_string(src, i)
            continue
        if src[i] == "{":
            depth += 1
        elif src[i] == "}":
            depth -= 1
            if depth == 0:
                return src[start:i + 1], i + 1
        i += 1
    return src[start:], len(src)


def strings_in(body):
    out = []
    i = 0
    while i < len(body):
        if body[i] in "\"'":
            s, i = read_lua_string(body, i)
            if len(s.strip()) > 1:
                out.append(s.strip())
            continue
        i += 1
    return out


def extract_quests():
    quests = []
    seen = set()
    qdir = os.path.join(DBT, "quests")
    for fn in sorted(os.listdir(qdir)):
        if not fn.endswith(".lua") or fn.startswith("Copy"):
            continue
        src = open(os.path.join(qdir, fn), encoding="utf-8", errors="replace").read()
        i = 0
        while True:
            j = src.find("add_quest", i)
            if j < 0:
                break
            b = src.find("{", j)
            if b < 0:
                break
            body, i = brace_body(src, b)
            g = re.search(r'global\s*=\s*"QUEST_(\w+)"', body)
            n = re.search(r'name\s*=\s*"([^"]*)"', body)
            if not g or not n:
                continue
            qid = quest_id(g.group(1))
            if qid in seen:
                continue
            seen.add(qid)
            lv = re.search(r"level\s*=\s*(\d+)", body)
            desc_at = body.find("desc")
            desc_body = body[desc_at:] if desc_at >= 0 else body
            # Prefer the first brace of strings after desc.
            lines = strings_in(desc_body)
            # The name string is not in desc_body if desc comes after name. Good.
            # hooks may contain no strings. Drop very short color codes.
            lines = [ln for ln in lines if not ln.startswith("#") and ln != n.group(1)]
            desc = "\n".join(lines[:12])
            quests.append((qid, n.group(1), desc, int(lv.group(1)) if lv else 1))
    return quests


def write_quests(quests):
    lines = ["-- Generated from DBT/scripts/quests. Do not edit by hand.", "dbt_quests = {"]
    for qid, name, desc, level in quests:
        lines.append("\t{id=%s, name=%s, desc=%s, level=%d}," % (lua_long(qid), lua_long(name), lua_long(desc), level))
    lines.append("}")
    lines.append("dbt_quest_by_id = {}")
    lines.append("for _, q in ipairs(dbt_quests) do dbt_quest_by_id[q.id] = q end")
    lines.append("dbt_quest_catalog = true")
    lines.append("")
    open(os.path.join(OUT, "quests.lua"), "w", encoding="utf-8", newline="\n").write("\n".join(lines))


def load_races():
    path = os.path.join(OUT, "general", "npcs", "races.lua")
    src = open(path, encoding="utf-8", errors="replace").read()
    return set(re.findall(r'define_as = "(RACE_[^"]+)"', src))


def main():
    for fn in os.listdir(CHAT_DIR):
        if fn.startswith("g_") and fn.endswith(".lua"):
            os.remove(os.path.join(CHAT_DIR, fn))
    quests = extract_quests()
    write_quests(quests)
    races = load_races()
    src = open(os.path.join(DBT, "dialogue.lua"), encoding="utf-8", errors="replace").read()
    talks = dict(HAND_RACE)
    made = 0
    dropped = []
    unbound = []
    failed_conds = []
    for name, body in split_functions(src):
        if name in SKIP_FUNCS or name.startswith("WT_"):
            continue
        parser = Parser(body)
        try:
            screen = parser.parse_block()
        except Exception as e:
            dropped.append("%s parse %s" % (name, e))
            continue
        failed_conds.extend("%s: %s" % (name, c) for c in parser.failed[:8])
        if not screen.texts and not screen.helpers and not screen.gates and not screen.branches:
            continue
        try:
            text = emit_chat(name, screen)
        except Exception as e:
            dropped.append("%s emit %s" % (name, e))
            continue
        if not balance_ok(text):
            dropped.append(name + " unbalanced")
            path = os.path.join(CHAT_DIR, "g_%s.lua" % name.lower())
            open(path, "w", encoding="utf-8", newline="\n").write(text)
            continue
        path = os.path.join(CHAT_DIR, "g_%s.lua" % name.lower())
        open(path, "w", encoding="utf-8", newline="\n").write(text)
        made += 1
        race = FUNC_RACE.get(name)
        if not race and ("RACE_" + name) in races:
            race = "RACE_" + name
        if race and race in races and race not in talks:
            talks[race] = "g_" + name.lower()
        elif not race or race not in races:
            unbound.append(name)
    lines = ["-- Generated by te4/tools/extract_talks.py. Do not edit by hand.", "dbt_talks = {"]
    for race in sorted(talks):
        lines.append("\t[ %s ] = %s," % (lua_long(race), lua_long(talks[race])))
    lines.append("}")
    lines.append("dbt_talks_ready = true")
    lines.append("")
    open(os.path.join(OUT, "talks.lua"), "w", encoding="utf-8", newline="\n").write("\n".join(lines))
    print("quests", len(quests))
    print("chats", made)
    print("dropped", len(dropped))
    for d in dropped[:30]:
        print(" drop", d)
    print("unbound", len(unbound))
    for u in unbound:
        print(" unbound", u)
    print("failed conds", len(failed_conds))
    for c in failed_conds[:40]:
        print(" cond", c)


if __name__ == "__main__":
    main()

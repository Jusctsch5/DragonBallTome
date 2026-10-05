import zipfile
z = zipfile.ZipFile(r"E:\Apps\steam\steamapps\common\TalesMajEyal\game\engines\te4-1.7.6.teae")
text = z.read("engine/Game.lua").decode("utf-8", "replace")
idx = text.find("function _M:registerDialog")
print(text[idx:idx+1500])
print("---- textzone head ----")
t = z.read("engine/ui/Textzone.lua").decode("utf-8", "replace").splitlines()
for i, line in enumerate(t[:120], 1):
    print(f"{i}:{line}")

import codecs, glob, random

for i in glob.glob("./subjects/*.csv"):
  file_content = []

  with codecs.open(i, "r", "utf-8") as f:
    f = f.read().split("\n")

    for c, r in enumerate(f[:-1]):
      if c == 0:
        file_content.append(r + ",year")
      else:
        file_content.append(r + ",19" + str(random.randint(10,99)))

  with codecs.open(i, "w", "utf-8") as out:
    out.write("\n".join(file_content) )


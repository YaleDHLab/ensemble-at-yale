import codecs, glob

# to get images in s3: aws s3 ls s3://lab-apps/ensemble-at-yale/page-images-revised/ > images_in_s3

app_image_keys = []
for i in glob.glob("Ensemble-Spreadsheet*"):
  with codecs.open(i, "r", "latin1") as f:
    f = f.read()
    for r in f.split("\r")[1:]:
      sr = r.split("\t")
      image_key = sr[3]
      app_image_keys.append(image_key)

s3_image_keys = []
with codecs.open("images_in_s3", "r", "utf-8") as f:
  f = f.read()
  for r in f.split("\n")[1:-1]:
    sr = r.split()
    image_key = sr[3].replace(".jpg", "")
    s3_image_keys.append(image_key)

# find the images in app_image_keys but not s3
diff = set(app_image_keys) - set(s3_image_keys)

with codecs.open("missing_images.txt", "w", "utf-8") as out:
  out.write("\n".join(list(diff)))

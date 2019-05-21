from collections import defaultdict
import glob, json, csv, os, shutil

# d[group][set_key] = [img_link, img_link, ...]
d = defaultdict(lambda: defaultdict(list))

for i in glob.glob('subjects/group_*.csv'):
  group = os.path.basename(i).replace('.csv','')
  if not isinstance(group, str):
    print(' ! missing group string', i)
    continue
  with open(i) as f:
    reader = csv.reader(f)
    for jdx, j in enumerate(reader):
      if jdx == 0: continue # skip headers
      d[group][j[3]].append(j[0])

  out_dir = os.path.join('pb_groups', group)
  if not os.path.exists(out_dir):
    os.makedirs(out_dir)

# find max number of pages in all playbills
max_pages = 0
for g in d:
  for i in d[g]:
    if len(d[g][i]) > max_pages:
      max_pages = len(d[g][i])

print(' ! max pages:', max_pages)

# get the col headers for each subjects csv
headers = ['set_key']
for i in range(max_pages):
  i = str(i)
  while len(i) < 2:
    i = '0' + i
  headers += ['image' + i]

for g in d:
  print(g)
  out_path = os.path.join('pb_groups', g, g + '-subjects.csv')
  with open(out_path, 'w') as out:
    writer = csv.writer(out)
    writer.writerow(headers)
    for i in d[g]:
      row = [i]
      for j in d[g][i]:
        img_basename = os.path.basename(j)
        row += [img_basename]
        destination = os.path.join('pb_groups', g, img_basename)
        try:
          shutil.copy('/Users/doug/Desktop/ensemble-images/' + img_basename, destination)
        except:
          print(' ! image missing', img_basename)
      while len(row) < max_pages:
        row += ['']

      writer.writerow(row)

# zip up the archives
for i in glob.glob('pb_groups/*'):
  os.system('zip -r ' + i + '.zip ' + i)

# upload
os.system('tar -zcf pb_groups.tar.gz pb_groups && aws s3 cp pb_groups.tar.gz s3://lab-data-collections/pb_groups.tar.gz --acl public-read --profile yale-admin')

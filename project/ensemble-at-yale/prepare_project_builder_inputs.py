from collections import defaultdict
import glob, json, csv, os, shutil

curate_images = False
curate_text = True

# map each group name to its group id in the ensemble platform
group_to_id = {
  'group_department_of_drama': '5919df62adb8170833fb4fb2',
  'group_founding_era': '5919e1cdadb8170833fb5313',
  'group_robert_brustein': '5919e4b3adb8170833fb5684',
  'group_lloyd_richards': '5919ee08adb8170833fb5fed',
  'group_stan_wojewodski': '5919f9ffadb8170833fb6be0',
  'group_james_bundy': '591a02c3adb8170833fb74c7',
}

# meta[set_key] = {link: '', year: '', playwright: '', director: ''}
meta = {}

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
      meta[j[3]] = {
        'link': 'http://ensemble.yale.edu/#/groups/' + group_to_id[group],
        'year': j[4],
        'playwright': j[5],
        'director': j[6],
      }
  out_dir = os.path.join('pb_groups', group)
  if not os.path.exists(out_dir):
    os.makedirs(out_dir)

# find max number of pages in all playbills
max_pages = 0
for g in d:
  for i in d[g]:
    if len(d[g][i]) > max_pages:
      max_pages = len(d[g][i])

print(' * max pages:', max_pages)

# get the col headers for each subjects csv
headers = ['set_key']
meta_keys = ['link', 'year', 'playwright', 'director']
for i in range(max_pages):
  i = str(i+1)
  while len(i) < 2:
    i = '0' + i
  headers += ['image' + i]
headers += meta_keys # add playbill metadata

# copy the page images from aws
if curate_images:
  os.system('aws s3 cp s3://lab-apps/ensemble-at-yale/page-images-revised/ ensemble-images --recursive')

for g in d:
  print(' * processing group', g)
  out_path = os.path.join('pb_groups', g, g + '-subjects.csv')
  with open(out_path, 'w') as out:
    writer = csv.writer(out)
    writer.writerow(headers)
    for i in d[g]:
      row = [i]
      for j in d[g][i]:
        img_basename = os.path.basename(j)
        row.append(img_basename)
        destination = os.path.join('pb_groups', g, img_basename)
        if curate_images:
          try:
            shutil.copy('ensemble-images/' + img_basename, destination)
          except:
            print(' ! image missing', img_basename)
      while len(row) <= max_pages:
        row.append('')
      for meta_key in meta_keys:
        row.append(meta[i][meta_key]) # add the metadata values to this record in the csv
      writer.writerow(row)

# zip up the archives
for i in glob.glob('pb_groups/*'):
  os.system('zip -r ' + i + '.zip ' + i)
  os.system('rm -r ' + i) # remove the non zipped directory

# upload if we've processed all data
if curate_images and curate_text:
  os.system('tar -zcf pb_groups.tar.gz pb_groups && aws s3 cp pb_groups.tar.gz s3://lab-data-collections/pb_groups.tar.gz --acl public-read --profile yale-admin')

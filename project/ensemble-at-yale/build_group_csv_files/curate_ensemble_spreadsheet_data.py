from collections import defaultdict, Counter
import codecs, glob, os, csv

# Usage: python curate_ensemble_spreadsheet_data.py

def build_group_spreadsheets():
  '''Read in the master playbill spreadsheet and create additional spreadsheets
  with metadata describing each playbill within each group'''
  # initialize a dictionary that will map eras to playbills of that era
  d = defaultdict(list)
  for i, delimiter in [
      ['Ensemble-Spreadsheet1-12COMPLETE.tsv', '\r'],
      ['Ensemble-Spreadsheet13-20COMPLETE.tsv', '\r'],
      ['EnsembleSpreadsheetPDFShows.tsv', '\n'],
    ]:
    with codecs.open(i, 'r', 'latin1') as f:
      for c, row in enumerate(f.read().split(delimiter)):
        if c == 0: continue # skip headers in the master spreadsheet
        else:
          row = row.split('\t')
          # gather fields required for group csv: file_path,thumbnail,width,height,page_no,set_key,year
          if not row[2].strip(): continue # skip rows without images
          file_name      = row[3] + '.jpg'
          file_path      = 'https://s3-us-west-2.amazonaws.com/lab-apps/ensemble-at-yale/page-images-revised/' + file_name
          thumbnail_path = 'https://s3-us-west-2.amazonaws.com/lab-apps/ensemble-at-yale/page-thumbs-revised/' + file_name
          page_number    = row[3].split('-')[-1].replace('p','').replace('0','')
          set_key        = '-'.join(row[3].split('-')[:-1])
          year           = row[6].replace('"','')
          written_by     = row[7].replace('"','')
          director       = row[8].replace('"','')
          location       = ' '.join( row[9].replace('"','').split() )
          non_theatrical = row[11]
          multiplay      = row[12]
          try:
            group_key    = row[13]
            if not group_key.strip(): continue
          except:
            print(' * could not process', i, c, len(row))
            if c % 100 == 0:
              print(row)
            continue
          if (non_theatrical == 'y' or multiplay == 'y'):
            #print('skipping', group_key, 'because it is non-theatrical or a multiplay')
            continue
          # The group key is the reference to the group of subject sets
          # And the set key is the unique identifier for all pages of a
          # playbill
          d[group_key].append([
            file_path, thumbnail_path,
            page_number, set_key, year, written_by,
            director, location, group_key
          ])
  for group_key in d.keys():
    with open('../subjects/group_' + group_key + '.csv', 'w') as group_out:
      csv_writer = csv.writer(group_out, delimiter=',')
      group_headers = [
        'file_path', 'thumbnail', 'page_no', 'set_key',
        'year', 'written_by', 'director', 'location',
        'group_key'
      ]
      # write the headers identified above
      csv_writer.writerow(group_headers)
      for r in d[group_key]: csv_writer.writerow(r)

if __name__ == '__main__':
  # Delete the legacy csv data in pwd and ../subjects
  for i in glob.glob('../subjects/group_*.csv'):
    os.system('rm {}'.format(i))
  # Build spreadsheets for each group / era of playbills
  build_group_spreadsheets()
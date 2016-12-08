from collections import defaultdict
import unicodecsv as csv
import codecs, glob, os

# Usage: python curate_ensemble_spreadsheet_data.py 

def build_group_spreadsheets():
  """Read in the master playbill spreadsheet and create additional spreadsheets
  with metadata describing each playbill within each group"""

  # initialize a dictionary that will map eras to playbills of that era
  d = defaultdict(list)

  for master_tsv in master_playbill_spreadsheets:
    with codecs.open(master_tsv, "r", "latin1") as f:

      # examine each row
      for c, row in enumerate(f.read().split("\r")):
        if c == 0:

          # skip the headers in the master spreadsheet
          continue

        else:
          row = row.split("\t")

          # gather fields required for group csv: file_path,thumbnail,width,height,page_no,set_key,year
          file_name      = row[3] + ".jpg"
          file_path      = "https://s3-us-west-2.amazonaws.com/lab-apps/ensemble-at-yale/page-images-revised/" + file_name
          thumbnail_path = "https://s3-us-west-2.amazonaws.com/lab-apps/ensemble-at-yale/page-thumbs-revised/" + file_name
          page_number    = row[3].split("-")[-1].replace("p","").replace("0","")
          set_key        = "-".join(row[3].split("-")[:-1])
          year           = row[6].replace('"','')
          written_by     = row[7].replace('"','')
          director       = row[8].replace('"','')
          location       = " ".join( row[9].replace('"','').split() )
          non_theatrical = row[11]
          multiplay      = row[12]
          group_key      = row[-1]

          if (non_theatrical == "y" or multiplay == "y"):
            print "skipping", group_key, "because it's non-theatrical or a multiplay"
            continue

          # The group key is the reference to the group of subject sets
          # And the set key is the unique identifier for all pages of a
          # playbill

          d[group_key].append([
            file_path, thumbnail_path,
            page_number, set_key, year, written_by,
            director, location, group_key
          ])

  for group_key in d.iterkeys():

    with open("../subjects/group_" + group_key + ".csv", "w") as group_out:
      csv_writer = csv.writer(group_out, delimiter=',')
      
      group_headers = [
        "file_path", "thumbnail", "page_no", "set_key",
        "year", "written_by", "director", "location", 
        "group_key"
      ]

      # write the headers identified above
      csv_writer.writerow(group_headers)

      for r in d[group_key]:
        csv_writer.writerow(r)


if __name__ == "__main__":

  # Delete the legacy csv data in pwd and ../subjects
  os.popen("rm ../subjects/group_*.csv")

  # assign a name to the master spreadsheets of playbill metadata
  master_playbill_spreadsheets = [
    "Ensemble-Spreadsheet1-12COMPLETE.tsv",
    "Ensemble-Spreadsheet13-20COMPLETE.tsv"
  ]

  # Build spreadsheets for each group / era of playbills
  build_group_spreadsheets()
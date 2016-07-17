from collections import defaultdict
import unicodecsv as csv
import codecs, glob, os

# Usage: python curate_ensemble_spreadsheet_data.py 

def add_dean_to_year(period_identifier, period_start, period_end, d):
  """
  Read in a unique identifier for the current period (e.g. "Brustein"), 
  the first and last dates of that period, and a dict
  in which to store mappings from year to director, and return an updated dict
  """
  for y in xrange(period_end - period_start + 1):
    if y == period_end:
      d[ str(period_start + y) ] = "boundary_year"
    else:
      d[ str(period_start + y) ] = period_identifier
  return d


def define_dean_periods():
  """
  Return a hashmap of each year in the collection mapped to the dean who supervised
  dramatic works during that year. Map boundary years to a special boundary identifier
  """
  d = {}  

  # Define the start and end years of each era
  d = add_dean_to_year("department_of_drama", 1925, 1955, d)
  d = add_dean_to_year("founding_era", 1955, 1966, d)
  d = add_dean_to_year("robert_brustein", 1966, 1979, d)
  d = add_dean_to_year("lloyd_richards", 1979, 1991, d)
  d = add_dean_to_year("stan_wojewodski", 1991, 2002, d)
  d = add_dean_to_year("james_bundy", 2002, 2016, d)

  return d


def fetch_height_and_widths(glob_path_to_group_csvs):
  """Read in a glob path to the group csvs with height and width information,
  and return a hashmap from unique play identifier to its height and
  width data """

  # create a dictionary in which to store the mapping from
  # image id to its height and width params
  d = {}

  for csv_file in glob_path_to_group_csvs:

    # The groups.csv file has its own organization (see below), 
    # and so should be skipped here
    if "group_" not in csv_file:
      continue

    with codecs.open(csv_file, "r", "utf-8") as f:
      f = f.read()
      rows = f.split("\n")
      for row in rows[1:]:
        split_row = row.split(",")
        
        # grab the play identifier from the url to its images
        play_identifier = split_row[0].split("yale.edu/images/")[1].replace(".jpg","")
        width = split_row[2]
        height = split_row[3]

        d[play_identifier] = {"height": height, "width": width}

  return d


def map_deans_to_controlled_vocabulary():
  """
  Return a mapping from dean/era strings as they appear in the DRA37Boxes 1-11
  spreadsheet to the controlled vocabulary used herein
  """
  d = {
    "Brustein": "robert_brustein",
    "Brustein - comes back in 1973": "robert_brustein",
    "Canfield": "f_curtis_canfield",
    "Cole": "edward_c_cole",
    "Eaton": "walter_prichard_eaton",
    "Nicoll": "allardyce_nicoll",
    "GPB": "george_pierce_baker",
    "Richards": "lloyd_richards",
    "Smith": "boyd_m_smith",
    "Stein": "howard_stein",
    "Stein - only 1972/1973 year": "howard_stein",
    "Wojewodski": "stan_wojewodski",
  }

  return d


def write_master_spreadsheet_headers(header_array):
  """Read in an array of headers, add new headers to that array, then write to disk"""
  for new_header in ["era", "height", "width"]:
    header_array.append(new_header)

  # write the headers in the ingest file and additional headers to the master spreadsheet
  with open(master_playbill_spreadsheet, "w") as master_out:
    csv_writer = csv.writer(master_out, delimiter=',')

    csv_writer.writerow(header_array)


def retrieve_year(last_year, year, playbill_identifier):
  """Read in the previous year and the current_year_field and return 
  the current row's year"""

  # If the current play has no year information, use the previous playbill's year
  # Otherwise, if the year value designates a range, print that fact and
  # use the former year in the range
  if year == "":
    print playbill_identifier, "has no year information, so using the previous playbill's year"
    year = last_year

  elif "-" in year:
    print playbill_identifier, "has a - in the year range; we will use the former year"
    year = year.split("-")[0]
  
  elif "/" in year:
    print playbill_identifier, "has a / in the year range; we will use the former year"
    year = year.split("/")[0]

  return year


def add_row_to_master_spreadsheet(split_row, play_era, playbill_height, playbill_width):
  """Read in a series of values for the current playbill and append to the master spreadsheet"""
  with open(master_playbill_spreadsheet, "a") as master_out:
    csv_writer = csv.writer(master_out, delimiter=',')
    
    out_vals = split_row
    for v in [play_era, playbill_height, playbill_width]:
      out_vals.append(v)

    csv_writer.writerow(out_vals)


def build_master_spreadsheet():
  """Read in the spreadsheet detailing the director to whom boundary-year plays belong,
  and write the subject csv's for ingestion into the Ensemble application"""

  # create an object to hold the year of the previous playbill
  last_year = ""

  with codecs.open("DRA37Boxes1-11.tsv", "r", "latin1") as f:
    rows = f.read().replace('"','').split("\n")

    # Skip the last row
    for c, row in enumerate(rows[:-1]):
      split_row = row.split("\t")

      if c == 0:
        write_master_spreadsheet_headers(split_row)

      else:

        # store the current row's primary key
        playbill_identifier = split_row[3]
        
        # If the current play is multipage or non-theatrical, skip it
        if split_row[11] != "":
          continue
        if split_row[12] != "":
          continue

        year = retrieve_year(last_year, split_row[6], playbill_identifier)
        last_year = year

        # fetch and normalize the play's era (if any)
        if split_row[13] != "":
          # if the era is defined, this is a boundary year: fetch its normalized representation
          play_era = normalized_deans[ split_row[13] ]
        else:
          # else fetch the era from the extant (a priori) mapping
          play_era = year_to_dean[year]
         
        # fetch the height and width information for the page
        try:
          height_and_width = height_width_mappings[playbill_identifier]
          playbill_height = height_and_width["height"]
          playbill_width = height_and_width["width"]
          set_key = playbill_identifier

        except KeyError:
          print playbill_identifier, "has no height and width information, so skipping"
          continue

        # add the current row information to the master spreadsheet
        add_row_to_master_spreadsheet(split_row, play_era, playbill_height, playbill_width)


def build_group_spreadsheets():
  """Read in the master playbill spreadsheet and create additional spreadsheets
  with metadata describing each playbill within each group"""

  # initialize a dictionary that will map eras to playbills of that era
  d = defaultdict(list)

  # don't use codecs here, as the csv reader will handle encoding
  with open(master_playbill_spreadsheet, "r") as f:
    
    # csv reader transforms each 'row' object into an array
    for c, row in enumerate(csv.reader(f)):
      if c == 0:

        # skip the headers in the master spreadsheet
        continue

      else:
        # gather fields required for group csv: file_path,thumbnail,width,height,page_no,set_key,year
        file_name      = row[3] + ".jpg"
        file_path      = "http://hcremacmini01.library.yale.edu/images/" + file_name
        thumbnail_path = "http://hcremacmini01.library.yale.edu/thumbs/" + file_name
        width          = row[16]
        height         = row[15]
        page_number    = row[3].split("-")[-1].replace("p","").replace("0","")
        set_key        = "-".join(row[3].split("-")[:-1])
        year           = row[6].replace('"','')
        written_by     = row[7].replace('"','')
        director       = row[8].replace('"','')
        location       = " ".join( row[9].replace('"','').split() )

        # The group key is the reference to the group of subject sets
        # And the set key is the reference to the playbill identifier
        group_key      = row[14].replace('"','')

        d[group_key].append([
          file_path, thumbnail_path, width, height, 
          page_number, set_key, year, written_by, 
          director, location
        ])

  for group_key in d.iterkeys():

    with open("../subjects/group_" + group_key + ".csv", "w") as group_out:
      csv_writer = csv.writer(group_out, delimiter=',')
      
      group_headers = [
        "file_path", "thumbnail", "width", "height",
        "page_no", "set_key", "year", "written_by", 
        "director", "location"
      ]

      # write the headers identified above
      csv_writer.writerow(group_headers)

      for r in d[group_key]:
        csv_writer.writerow(r)


def build_overview_group_spreadsheet():
  """Read in a variety of external information and write a groups.csv
  that provides metadata for each of the various groups in the 
  application"""

  # The following fields are required within the groups.csv file
  #   key, name, description, cover_image_url, external_url
  # additional metadata fields may be added as desired

  # define each group's data in d
  d = [
    
    {
      "key": "department_of_drama",
      "name": "Department of Drama",
      "description": "Lorem ipsum dolor sit amet, cu eam utamur legimus mnesarchum. Te eum autem sensibus. Graeci putent per an, pertinax complectitur interpretaris at vis. Te errem oporteat mel, mel iudico quodsi ei, est aliquid maiestatis conclusionemque ex. Dolorem admodum ad his.",
      "cover_image_url": "https://s3-us-west-2.amazonaws.com/ensemble-at-yale/drama-era-images/department_of_drama_1.jpg",
      "external_url": "NA",
      "start_year": "1925",
      "end_year": "1955",
      "order": "0"
    },

    {
      "key": "founding_era",
      "name": "Founding Era",
      "description": "Lorem ipsum dolor sit amet, cu eam utamur legimus mnesarchum. Te eum autem sensibus. Graeci putent per an, pertinax complectitur interpretaris at vis. Te errem oporteat mel, mel iudico quodsi ei, est aliquid maiestatis conclusionemque ex. Dolorem admodum ad his.",
      "cover_image_url": "https://s3-us-west-2.amazonaws.com/ensemble-at-yale/drama-era-images/founding_era_1.jpg",
      "external_url": "NA",
      "start_year": "1955",
      "end_year": "1966",
      "order": "1"
    },

    {
      "key": "robert_brustein",
      "name": "Robert Brustein",
      "description": "Lorem ipsum dolor sit amet, cu eam utamur legimus mnesarchum. Te eum autem sensibus. Graeci putent per an, pertinax complectitur interpretaris at vis. Te errem oporteat mel, mel iudico quodsi ei, est aliquid maiestatis conclusionemque ex. Dolorem admodum ad his.",
      "cover_image_url": "https://s3-us-west-2.amazonaws.com/ensemble-at-yale/drama-era-images/robert_brustein_1.jpg",
      "external_url": "NA",
      "start_year": "1966",
      "end_year": "1979",
      "order": "2"
    },

    {
      "key": "lloyd_richards",
      "name": "Lloyd Richards",
      "description": "Lorem ipsum dolor sit amet, cu eam utamur legimus mnesarchum. Te eum autem sensibus. Graeci putent per an, pertinax complectitur interpretaris at vis. Te errem oporteat mel, mel iudico quodsi ei, est aliquid maiestatis conclusionemque ex. Dolorem admodum ad his.",
      "cover_image_url": "https://s3-us-west-2.amazonaws.com/ensemble-at-yale/drama-era-images/lloyd_richards_1.jpg",
      "external_url": "NA",
      "start_year": "1979",
      "end_year": "1991",
      "order": "3"
    },

    {
      "key": "stan_wojewodski",
      "name": "Stanley Wojewodski Jr.",
      "description": "Lorem ipsum dolor sit amet, cu eam utamur legimus mnesarchum. Te eum autem sensibus. Graeci putent per an, pertinax complectitur interpretaris at vis. Te errem oporteat mel, mel iudico quodsi ei, est aliquid maiestatis conclusionemque ex. Dolorem admodum ad his.",
      "cover_image_url": "https://s3-us-west-2.amazonaws.com/ensemble-at-yale/drama-era-images/stan_wojewodski_1.jpg",
      "external_url": "NA",
      "start_year": "1991",
      "end_year": "2002",
      "order": "4"
    },

    {
      "key": "james_bundy",
      "name": "James Bundy",
      "description": "Lorem ipsum dolor sit amet, cu eam utamur legimus mnesarchum. Te eum autem sensibus. Graeci putent per an, pertinax complectitur interpretaris at vis. Te errem oporteat mel, mel iudico quodsi ei, est aliquid maiestatis conclusionemque ex. Dolorem admodum ad his.",
      "cover_image_url": "https://s3-us-west-2.amazonaws.com/ensemble-at-yale/drama-era-images/james_bundy_1.jpg",
      "external_url": "NA",
      "start_year": "2002",
      "end_year": "2016", 
      "order": "5"
    }
  ]

  # write the csv headers
  with open("../subjects/groups.csv", "w") as groups_csv_out:
    csv_writer = csv.writer(groups_csv_out, delimiter=',')

    groups_csv_headers = [k for k in d[0]]

    # write the headers identified above
    csv_writer.writerow(groups_csv_headers)
  
    # iterate over keys in d and build groups.csv
    for group in d:
      group_vals = [group[k] for k in group.iterkeys()]
      csv_writer.writerow(group_vals)


if __name__ == "__main__":

  # Delete the legacy csv data in ../subjects
  os.popen("rm ../subjects/*.csv")

  # Specify a path to the subject csv's within the Ensemble at Yale app
  path_to_group_csvs = glob.glob("group_csvs_organized_by_box_folder/group_*.csv") 

  # assign a name to the master spreadsheet of playbill metadata
  master_playbill_spreadsheet = "master_ensemble_playbill_spreadsheet.csv"

  # Create a mapping from image identifiers to height and width information
  height_width_mappings = fetch_height_and_widths(path_to_group_csvs)

  # Build a mapping from year to dean/play era. This mapping won't treat boundary years
  year_to_dean = define_dean_periods() 
 
  # Build a mapping of deans to controlled vocabulary representation of those deans
  normalized_deans = map_deans_to_controlled_vocabulary()

  # Build master spreadsheet of data from required sources
  build_master_spreadsheet() 

  # Build spreadsheets for each group / era of playbills
  build_group_spreadsheets()

  # Build final spreadsheet that details each group
  build_overview_group_spreadsheet()
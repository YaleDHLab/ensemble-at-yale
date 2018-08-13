from email.mime.application import MIMEApplication
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.utils import COMMASPACE, formatdate
from collections import defaultdict
import dateutil.parser
import smtplib, os, sys, subprocess, shlex, schedule
import time, datetime, json, pymongo, glob, shutil

def prepare_newly_transcribed_outdir():
  '''Prepare the directory of newly transcribed records'''
  shutil.rmtree(out_dir)
  os.makedirs(out_dir)

def get_newly_transcribed_records():
  '''Identify newly transcribed records'''
  subject_sets = db.subject_sets.find()
  subjects = db.subjects
  
  extant_transcribed_records = get_transcribed_records()
  new_subject_set_ids = []

  for i in subject_sets:
    subject_set_id = i['_id']
    subject_set_key = i['key']

    if i['retired_from_transcribe'] == 1:
      if str(subject_set_id) in extant_transcribed_records:
        continue
      else:
        extant_transcribed_records.append(str(subject_set_id))
    
      # get required fields
      title = metadata[subject_set_key]['title']
      transcribed_fields = get_transcribed_fields(subject_set_id)
      start_date, end_date = get_transcribed_dates(transcribed_fields)
      
      # get a timestamp for outfiles
      now = datetime.datetime.now()
      timestamp = str( (now - datetime.datetime(1970,1,1)).total_seconds() )

      # convert subject set to string for file paths
      subject_set_id = str(subject_set_id)

      write_metadata(timestamp, subject_set_id, start_date, end_date, title)
      write_people(timestamp, subject_set_id, transcribed_fields)

  with open('transcribed_subject_set_ids.json', 'w') as out:
    json.dump(extant_transcribed_records, out)

def get_transcribed_records():
  if os.path.exists('transcribed_subject_set_ids.json'):
    return json.load(open('transcribed_subject_set_ids.json'))
  else:
    return []

def write_metadata(timestamp, subject_set_id, start_date, end_date, title):     
  with open(out_dir + '/' + timestamp + '_' + subject_set_id + '_metadata.tsv', 'w') as out:
    out.write('start_date\t' + start_date + '\n')
    out.write('end_date\t' + end_date + '\n')
    out.write('title\t' + title + '\n')

def write_people(timestamp, subject_set_id, transcribed_fields):
  with open(out_dir + '/' + timestamp + '_' + subject_set_id + '_people.tsv', 'w') as out:

    role_fields = [
      'ey_ps_responsibility',
      'ey_ac_charactername'
    ]

    person_fields = [
      'ey_ps_person',
      'ey_ac_actor'
    ]

    subject_id_to_person = defaultdict(lambda: defaultdict())
    subject_id_to_role = defaultdict(lambda: defaultdict())

    for k in transcribed_fields:
      value = k['value']
      field = k['field']
      subject_set_id = k['parent_subject_id']

      if field in role_fields:
        subject_id_to_role[subject_set_id] = value

      elif field in person_fields:
        subject_id_to_person[subject_set_id] = value

    for k in transcribed_fields:
      value = k['value']
      field = k['field']
      subject_set_id = k['parent_subject_id']

      if field == 'ey_transcribed_playwright':
        out.write('\t'.join(['playwright', value]) + '\n')

      elif field == 'ey_transcribed_director':
        out.write('\t'.join(['director', value]) + '\n')

      elif field in role_fields:
        person = subject_id_to_person[subject_set_id]
        out.write('\t'.join([value, person]) + '\n')

def get_transcribed_dates(transcribed_fields):
  '''Return clean start and end dates for this play'''
  clean_start = ''
  clean_end = ''
  for k in transcribed_fields:
    value = k['value']

    if k['field'] == 'ey_transcribed_date_start':
      start_datetime = dateutil.parser.parse(value)
      clean_start = start_datetime.strftime('%Y-%m-%d')

    elif k['field'] == 'ey_transcribed_date_stop':
      stop_datetime = dateutil.parser.parse(value)
      clean_stop = stop_datetime.strftime('%Y-%m-%d')
  return [clean_start, clean_stop]

def get_transcribed_fields(subject_set_id):
  '''Determine the opening and closing dates for this play'''
  transcribed_fields = []

  fields = [
    'ey_transcribed_date_start',
    'ey_transcribed_date_stop',
    'ey_ac_charactername',
    'ey_ac_actor', 
    'ey_ps_responsibility',
    'ey_ps_person'
  ]

  for field in fields:
    query = {
      'subject_set_id': subject_set_id,
      'data.' + field: { '$exists': 'true' }
    }

    select = {
      'data.' + field: 1,
      'parent_subject_id': 1,
      '_id': 0
    }

    results = list( db.subjects.find(query, select) )
    for i in results:
      value = i['data'][field]
      
      try:
        parent_subject_id = i['parent_subject_id']
      except:
        parent_subject_id = ''

      transcribed_fields.append({
        'value': value,
        'field': field,
        'parent_subject_id': parent_subject_id
      })


  # now retrieve results for the other data format (configured in the site workflows)
  # use db.subjects.find({'type':'ey_transcribed_playwright'}).pretty()
  fields = [
    'ey_transcribed_playwright', 
    'ey_transcribed_director',
  ]

  for field in fields:
    query = {
      'subject_set_id': subject_set_id,
      'type': field
    }

    select = {
      'parent_subject_id': 1,
      'data': 1,
      '_id': 0
    }

    results = list( db.subjects.find(query, select) )
    for i in results:
      value = i['data']['value']
      
      try:
        parent_subject_id = i['parent_subject_id']
      except:
        parent_subject_id = ''

      transcribed_fields.append({
        'value': value,
        'field': field,
        'parent_subject_id': parent_subject_id
      })

  return transcribed_fields

def get_project_metadata():
  '''Return json mapping each playbill to its given metadata'''
  metadata = {}
  for i in metadata_files:
    with open(i) as f:
      f = f.read()
    for j in f.split('\r')[1:]:
      cells = j.split('\t')
      
      # pluck out metadata fields of interest
      subject_set_id = cells[3].split('-p')[0]
      title = cells[4]
      dates = cells[5]
      year = cells[6].strip()

      opening_date, closing_date = clean_metadata_dates(dates, year)

      metadata[subject_set_id] = {
        'dates': dates,
        'opening_date': opening_date,
        'closing_date': closing_date,
        'title': title
      }
  return metadata

def clean_metadata_dates(dates, year):
  '''Clean up those dates'''
  try:
    opening_date, closing_date = [k.strip() for k in dates.split('-')]
  except:
    opening_date = ''
    closing_date = ''

  if opening_date:
    month = opening_date.split()[0]
    try:
      float(month)
      month = ''
    except:
      pass

  # clean up strings
  if opening_date and year:
    opening_date = opening_date + ' ' + year
  elif year:
    opening_date = year

  if closing_date and year:
    closing_date = month + ' ' + closing_date + ' ' + year
  elif year:
    closing_date = year

  return [opening_date, closing_date]

def zip_newly_transcribed():
  '''Zip up the output from a mongo dump'''
  command = 'tar -zcf newly_transcribed.tar.gz newly_transcribed'
  subprocess.call(shlex.split(command))

def send_mail(server='127.0.0.1'):
  '''Send an email with a zipfile attachment'''
  send_from = config['email_from_address']
  send_to = config['email_to_address']
  subject = config['email_subject']
  text = config['email_message']
  archive = 'newly_transcribed.tar.gz'

  if isinstance(send_to, list):
    send_to = COMMASPACE.join(send_to)

  msg = MIMEMultipart()
  msg['From'] = send_from
  msg['To'] = send_to
  msg['Date'] = formatdate(localtime=True)
  msg['Subject'] = subject
  msg.attach(MIMEText(text))

  with open(archive, 'rb') as filehandler:
    part = MIMEApplication( filehandler.read(), Name=os.path.basename(archive) )
    part['Content-Disposition'] = 'attachment; filename="%s"' % os.path.basename(archive)
    msg.attach(part)

  smtp = smtplib.SMTP(server)
  smtp.sendmail(send_from, send_to, msg.as_string())
  print('email sent at', datetime.datetime.utcnow())
  smtp.close()

def email_newly_transcribed():
  '''Email all newly transcribed records'''
  prepare_newly_transcribed_outdir()
  get_newly_transcribed_records()
  zip_newly_transcribed()
  send_mail()

if __name__ == '__main__':

  # load the user configurations
  config = {
    "email_from_address": "douglas.duhaime@gmail.com",
    "email_to_address": "douglas.duhaime@gmail.com",
    "email_subject": "Newly transcribed records",
    "email_message": "Here are the newly transcribed records"
  }

  # specify the path to the input tsv files
  metadata_files = glob.glob('project/ensemble-at-yale/build_group_csv_files/*.tsv')
  metadata = get_project_metadata()

  # create a db connection
  db_name = 'ensembleDb'
  client = pymongo.MongoClient('localhost', 27017)
  db = client[db_name]

  # build the outfiles
  out_dir = 'newly_transcribed'
  if not os.path.exists(out_dir):
    os.makedirs(out_dir)

  # send the email
  schedule.every().thursday.at('14:42').do(email_newly_transcribed)

  while 1:
    schedule.run_pending()
    time.sleep(1)

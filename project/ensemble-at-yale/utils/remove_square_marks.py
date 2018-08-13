from pymongo import MongoClient
import pymongo

client = MongoClient('localhost', 27017)
db = client.ensembleDb

classifications = db['classifications'].find()
for i in classifications:
  annotation = i['annotation']

  # only process records with w, h attributes
  try:
    if annotation['width'] == annotation['height']:
      _id = i['_id']
      db['classifications'].delete_one({'_id': _id})
  except KeyError:
    pass

subjects = db['subjects'].find()
for i in subjects:
  try:
    region = i['region']
    if region['width'] == region['height']:
      _id = i['_id']
      db['subjects'].delete_one({'_id': _id})
  except KeyError:
    continue

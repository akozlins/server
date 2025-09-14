#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.12"
# dependencies = [ "influxdb_client", "numpy", "pandas", "requests" ]
# ///

import math

import influxdb_client
import numpy
import pandas
import requests

INFLUX_URL = 'http://influxdb:8086'
INFLUX_TOKEN = ''
INFLUX_ORG = 'hass'
INFLUX_BUCKET = 'hass'
VM_URL = 'http://victoria:8428'
VM_DB = 'hass_influxdb'

client = influxdb_client.InfluxDBClient(url=INFLUX_URL, token=INflux2vm.pyFLUX_TOKEN, org=INFLUX_ORG)
api = client.query_api()

df = api.query_data_frame(f'''
from(bucket: "{INFLUX_BUCKET}")
|> range(start: 0)
|> drop(columns: ["_start","_stop"])
''')
df = pandas.concat(df)

# delete columns
df = df.drop(['result','table'], axis=1)
# make id to name dict
id2name = df[df['_field'] == 'friendly_name_str'].set_index('entity_id')['_value'].to_dict()
df['friendly_name'] = df['entity_id'].map(id2name)
df = df[~df['_field'].str.endswith('_str')]

# delete entities
df = df[~df['entity_id'].isin([ '192_168_178_31' ])]

# delete domains
df = df[~df['domain'].isin([ 'automation', 'calendar', 'number', 'sun', 'update' ])]
# delete attributes
df = df[~df['_field'].isin([ 'device_class', 'icon', 'max', 'min', 'state_class' ])]

# remove non-numeric values
df['_value'] = pandas.to_numeric(df['_value'], errors='coerce')
df = df.dropna(subset=['_value'])

# keep first and last entries in sets of non-changing values
#df = df[(df['_value'].shift(periods=+1) != df['_value']) | (df['_value'].shift(periods=-1) != df['_value'])]

# remove entities with same value
df = df.groupby(['entity_id','_field']).filter(lambda g: g['_value'].nunique() > 1)
#df = df.groupby(['entity_id','_field']).filter(lambda g: not g['_value'].eq(0).all())

def escape(s) :
    return s.replace('\\',r'\\').replace('"',r'\"').replace(',',r'\,').replace(' ',r'\ ').replace('=',r'\=').replace('\n',r'\n').replace('\r',r'\r').replace('\t',r'\t')

# make metrics:
# - name (prefix)
metrics = df['domain'] + '.' + df['entity_id']
# - tags
df['unit_of_measurement'] = df['_measurement']
for col in df :
    if col.startswith('_') or col in [ 'result', 'table' ] : continue
    metrics += ',' + col + '=' + df[col].apply(escape)
# - value (postfix)
metrics += ' ' + df['_field'].apply(escape) + '=' + df['_value'].astype(str).apply(escape)
# - time
metrics += ' ' + df['_time'].astype(int).astype(str)

for chunk in numpy.array_split(metrics, math.ceil(len(metrics)/10000)) :
    requests.post(f"{VM_URL}/write?db={VM_DB}", data='\n'.join(chunk))

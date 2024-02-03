import metpy.io
import pandas as pd
from io import StringIO
import os

def metar_processing():
    # upload json as dataframe
    df = pd.read_json(os.getcwd() + r'\functions\related_archives\response.json')
    # transform dataframe to csv 
    df.to_csv(os.getcwd() + r'\functions\related_archives\metar.csv', index=False)

    all_metars = '\n'.join(line.split(',')[2] for line in open(os.getcwd() + r'\functions\related_archives\metar.csv', 'rt'))
    df = metpy.io.parse_metar_file(StringIO(all_metars))

    # json documentarion https://unidata.github.io/MetPy/latest/api/generated/metpy.io.parse_metar_file.html

    # columns to be deleted
    drop_cols = ['elevation', 'latitude', 'longitude', 'remarks', 'air_pressure_at_sea_level', 'eastward_wind', 'northward_wind', 'current_wx1_symbol', 'current_wx2_symbol', 'current_wx3_symbol', 'cloud_coverage']

    # deletar colunas
    df = df.drop(columns=drop_cols)
    return df
import metpy.io
import pandas as pd
from io import StringIO
import os

def metar_processing():
    # puxa json como dataframe
    df = pd.read_json(os.getcwd() + r'\code\functions\related_archives\response.json')
    # transforma e exporta o dataframe em csv 
    df.to_csv(os.getcwd() + r'\code\functions\related_archives\metar.csv', index=False)

    all_metars = '\n'.join(line.split(',')[2] for line in open(os.getcwd() + r'\code\functions\related_archives\metar.csv', 'rt'))
    df = metpy.io.parse_metar_file(StringIO(all_metars))

    # documentação de colunas https://unidata.github.io/MetPy/latest/api/generated/metpy.io.parse_metar_file.html

    # colunas deletadas
    colunas_para_deletar = ['elevation', 'latitude', 'longitude', 'remarks', 'air_pressure_at_sea_level', 'eastward_wind', 'northward_wind', 'current_wx1_symbol', 'current_wx2_symbol', 'current_wx3_symbol', 'cloud_coverage']

    # deletar colunas
    df = df.drop(columns=colunas_para_deletar)
    return df
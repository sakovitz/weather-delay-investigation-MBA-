import metpy.io
import pandas as pd
from io import StringIO

def metar_processing(path, archive_name):
    # upload json as dataframe
    df = pd.read_json(path + r'\\' + archive_name)
    # transform dataframe to csv 
    df.to_csv(path + '\metar.csv', index=False)

    all_metars = '\n'.join(line.split(',')[2] for line in open(path + '\metar.csv', 'rt'))
    df = metpy.io.parse_metar_file(StringIO(all_metars))

    # json documentarion https://unidata.github.io/MetPy/latest/api/generated/metpy.io.parse_metar_file.html

    # columns to be deleted
    drop_cols = ['elevation', 'latitude', 'longitude', 'remarks', 'air_pressure_at_sea_level', 'eastward_wind', 'northward_wind', 'current_wx1_symbol', 'current_wx2_symbol', 'current_wx3_symbol', 'cloud_coverage']

    # deletar colunas
    df = df.drop(columns=drop_cols)

    # Certifique-se de que 'date_time' está em formato de data
    df['date_time'] = pd.to_datetime(df['date_time'])

    # Subtrair 3 meses e 1 ano
    df['date_time'] = df['date_time'] - pd.DateOffset(months=3, years=1)

    # Verifique se a transformação foi feita corretamente
    print(df['date_time'].head())

    return df
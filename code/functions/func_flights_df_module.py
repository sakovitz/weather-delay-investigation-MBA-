import pandas as pd
from io import StringIO
import os

def flights_processing():
    # get and transform csv to dataframe
    df = pd.read_csv(os.getcwd() + r'\functions\related_archives\VRA_2023_12.csv', sep=';')

    # CSV documentarion https://www.gov.br/anac/pt-br/acesso-a-informacao/dados-abertos/areas-de-atuacao/voos-e-operacoes-aereas/voo-regular-ativo-vra/62-voo-regular-ativo-vra

    # columns list to be deleted
    drop_col = ['Sigla ICAO Empresa Aérea', 'Número Voo', 'Código DI', 'Código Tipo Linha']

    # Drop column
    df = df.drop(columns=drop_col)

    #rename columns dict
    columns_names = ['origin','scheduled_departure','real_departure','destiny','expected_arrival','real_arrival','flight_situation']

    # using 'rename' metod to rename columns
    df.columns = columns_names

    # changing 'flight_situation' columns values (to english)
    maping = {
    'REALIZADO': 'performed',
    'CANCELADO': 'canceled',
    'NÃO INFORMADO': 'not reported'
    }

    df['flight_situation'] = df['flight_situation'].replace(maping)

    return df

import pandas as pd
from io import StringIO

def flights_processing(path):
    # get and transform csv to dataframe
    df = pd.read_csv(path, sep=';')

    # CSV documentarion https://www.gov.br/anac/pt-br/acesso-a-informacao/dados-abertos/areas-de-atuacao/voos-e-operacoes-aereas/voo-regular-ativo-vra/62-voo-regular-ativo-vra

    # columns list to be deleted
    drop_col = ['Sigla ICAO Empresa Aérea', 'Número Voo', 'Código DI', 'Código Tipo Linha']

    # Drop column
    df = df.drop(columns=drop_col)

    #rename columns dict
    columns_names = ['origin','scheduled_departure','real_departure','destiny','expected_arrival','real_arrival','flight_situation']

    # using 'rename' metod to rename columns
    df.columns = columns_names

    # Drop columns that datetime is null
    df = df.dropna(subset=['scheduled_departure']).dropna(subset=['real_departure']).dropna(subset=['expected_arrival']).dropna(subset=['real_arrival'])

    # Drop columns that ICAO is null
    df = df.dropna(subset=['origin']).dropna(subset=['destiny'])

    # changing 'flight_situation' columns values (to engliash)
    maping = {
    'REALIZADO': 'performed',
    'CANCELADO': 'canceled',
    'NÃO INFORMADO': 'not reported'
    }
    # changing now \/
    df['flight_situation'] = df['flight_situation'].replace(maping)

    # transforming date columns (that are type: object to datetime64)
    df['scheduled_departure'] = pd.to_datetime(df['scheduled_departure'], format='%d/%m/%Y %H:%M')
    df['real_departure'] = pd.to_datetime(df['real_departure'], format='%d/%m/%Y %H:%M')
    df['expected_arrival'] = pd.to_datetime(df['expected_arrival'], format='%d/%m/%Y %H:%M')
    df['real_arrival'] = pd.to_datetime(df['real_arrival'], format='%d/%m/%Y %H:%M')
    

    #now we need to put datetime on Zulu. VRA csv is Brazilia time (-03) so need to add 3 hours
    # Creating object Timedelta representing 3 hours
    three_hours = pd.to_timedelta('3 hours')

    # Adding 3 hours to datetime columns
    df['scheduled_departure'] = df['scheduled_departure'] + three_hours
    df['real_departure'] = df['real_departure'] + three_hours
    df['expected_arrival'] = df['expected_arrival'] + three_hours
    df['real_arrival'] = df['real_arrival'] + three_hours
    return df

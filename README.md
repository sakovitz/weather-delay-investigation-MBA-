Investigation of Domestic Flight Delays at Guarulhos Airport (SBGR) using just METAR messages
=====
[![MBA USP](https://img.shields.io/badge/MBA-USP-blue)](https://mbauspesalq.com/)
[![REDEMET](https://img.shields.io/badge/REDEMET-c60dde)](https://www.redemet.aer.mil.br/)
[![ANAC](https://img.shields.io/badge/ANAC-blue)](https://www.gov.br/anac/pt-br)
[![MetPy](https://img.shields.io/badge/MetPy-1.6.1-green)](https://github.com/Unidata/MetPy/blob/main/README.md)
[![Jupyter](https://img.shields.io/badge/Jupyter-notebook-c93810)](https://jupyter.org/)

This repository contains a research project on domestic flight delays at Guarulhos International Airport (SBGR) in Brazil. The analysis is conducted solely based on METAR (Meteorological Aerodrome Report) information and delay times recorded.

Objective:
The main aim of this investigation is to understand the relationship between meteorological conditions, as reported by METAR, and delays in domestic flights at Guarulhos Airport. Through the analysis of this data, we seek to identify patterns and trends that may contribute to improvements in operational efficiency and decision-making for airlines and the airport.

Why SBGR (Guarulhos Airport)?
This research is just a POC (proof of concept) and SBGR is the biggest airport in Brazil. Spanning across 11,905,056.52 square meters, equipped with 51 boarding bridges, and facilitating around 205 landings and takeoffs per day. Notably, it is situated in a region characterized by considerable meteorological diversity.

Repository Contents
Scripts: Source code and scripts used for data collection, processing, and analysis.

Data: METAR dataset (from REDEMET api) and delay information from ANAC.

Results: Analysis results, graphs, and conclusions obtained during the investigation.

I hope this repository provides valuable insights into flight delays at Guarulhos Airport and contributes to improving the understanding and management of these events. Happy analyzing!

📚 Python Libraries
-------------------
[![MetPy](https://img.shields.io/badge/MetPy-1.6.1-green)](https://pypi.org/project/MetPy/)
[![Pandas](https://img.shields.io/badge/Pandas-2.2.0-c60dde)](https://pypi.org/project/pandas/)

Note: MetPy library use is just to transform METAR messages on to a Pandas DataFrame using `parse_metar_file()`

📡 ANAC Data instructions
---------
[![ANAC](https://img.shields.io/badge/ANAC-blue)](https://www.gov.br/anac/pt-br)

The flight schedule information is gathered from data made available by ANAC in CSV format (monthly) [here](https://www.gov.br/anac/pt-br/assuntos/dados-e-estatisticas/historico-de-voos). For a detailed explanation of variables (columns), you can refer to the documentation [here](https://www.gov.br/anac/pt-br/acesso-a-informacao/dados-abertos/areas-de-atuacao/voos-e-operacoes-aereas/voo-regular-ativo-vra/62-voo-regular-ativo-vra).

📡 REDEMET API instructions
---------------------------
[![REDEMET](https://img.shields.io/badge/REDEMET-c60dde)](https://www.redemet.aer.mil.br/)

- You will need a api key to have access. You can get [here](https://www.atd-1.com/cadastro-a)
- use tools like "Postman", "Insomnia",...
- address: https://api-redemet.decea.mil.br/mensagens/metar/
- Airport ICAO code: like SBGR
- api key: api_key=yourkeyhere
- initial date: data_ini=YYYYMMDD
- final date: data_fim=YYYYMMDD
- results per page: page_tam=200 (the max is 200)

    use example:https://api-redemet.decea.mil.br/mensagens/metar/SBGR?api_key=yourkeyhere&data_ini=2023010100&data_fim=2023123100&page_tam=200

 ```
    result example:
    {
        "status": true,
        "message": 200,
        "data": {
            "current_page": 1,
            "data": [
                {
                    "id_localidade": "SBGR",
                    "validade_inicial": "2023-01-01 00:00:00",
                    "mens": "METAR SBGR 010000Z 08003KT 9999 BKN015 21/19 Q1019=",
                    "recebimento": "2022-12-31 23:55:40"
                }
            ],
            "first_page_url": "/?page_tam=1&data_ini=2023010100&data_fim=2023123100&page=1",
            "from": 1,
            "last_page": 9290,
            "last_page_url": "/?page_tam=1&data_ini=2023010100&data_fim=2023123100&page=9290",
            "next_page_url": "/?page_tam=1&data_ini=2023010100&data_fim=2023123100&page=2",
            "path": "/",
            "per_page": 1,
            "prev_page_url": null,
            "to": 1,
            "total": 9290
        }
    }

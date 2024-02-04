Functions Documentarion
=======================

📚 func_metar_df_module
--------------------
`metar_processing(path, archive_name)` - A function that returns a Pandas DataFrame containing METAR information organized into individual columns. This function transform a Json file with METAR messages and uses MetPy's function [parse_metar_file()](https://unidata.github.io/MetPy/latest/api/generated/metpy.io.parse_metar_file.html) to transform into a Pands Dataframe.

**Parameters:**
- `path`: Valid string path without a archive (ex. `'D:\directory\code\functions\related_archives'`). You can use relative paths like `os.getcwd() + r'\functions\related_archives'`
- `archive_name`: Valid string with a Json archive name (ex. `'response.json'`)

**Note:** Altimeter in QNH (ex. 1013.25) will be converted to mercury (ex. 29.92)

**DataFrame Columns:**
- `station_id:` Station Identifier ICAO (ex. SBGR)
- `date_time:` Date and time of the observation, datetime object in ZULU
- `wind_direction:` Direction the wind is coming from, measured in degrees
- `wind_speed:` Wind speed, measured in knots
- `wind_gust:` Wind gust, measured in knots
- `visibility:` Visibility distance, measured in meters
- `current_wx1:` Current weather (1 of 3) (ex. -RA)
- `current_wx2:` Current weather (2 of 3)
- `current_wx3:` Current weather (3 of 3)
- `low_cloud_type:` Low-level sky cover (ex. FEW)
- `low_cloud_level:` Height of low-level sky cover, measured in feet
- `medium_cloud_type:` Medium-level sky cover (ex. OVC)
- `medium_cloud_level:` Height of medium-level sky cover, measured in feet
- `high_cloud_type:` High-level sky cover (ex. FEW)
- `high_cloud_level:` Height of high-level sky cover, measured in feet
- `highest_cloud_type:` Highest-level Sky cover (ex. CLR)
- `highest_cloud_level:` Height of highest-level sky cover, measured in feet
- `air_temperature:` Temperature, measured in degrees Celsius
- `dew_point_temperature:` ew point, measured in degrees Celsius
- `altimeter:` Altimeter value, measured in inches of mercury (ex. 29.91)

**Import:** `from functions.func_metar_df_module import metar_processing`

📚 func_flights_df_module
-----------------------
`flights_processing(path)` - A function that returns a Pandas DataFrame containing Flights records. This function transform a csv file with flights informations to a Pandas DataFrame.

**Parameters:**
- `path`: Valid string path to a csv file (ex. `'D:\directory\code\functions\related_archives\archive.csv'`). You can use relative paths like `os.getcwd() + r'\functions\related_archives\VRA_2023_12.csv'`

**Note:** The 'datetime' data extracted from ANAC is in the Brasília time zone (GMT -03), which is why the `flights_processing()` function convert it to Zulu time.

**Note 2:** Records with null values in the 'datetime' field are removed from the final dataframe. 

**DataFrame Columns:**
- `origin:` Origin airport ICAO (ex. SBGR)
- `scheduled_departure:` TimeStamp scheduled departure in Zulu time
- `real_departure:` TimeStamp real departure in Zulu time
- `destiny:` Destiny airport ICAO (ex. SBGR)
- `expected_arrival:` TimeStamp arrival in Zulu time
- `real_arrival:` TimeStamp real arrival in Zulu time
- `flight_situation:` If the flight was canceled or performed (contains 'not reported')

**Import:** `from functions.func_flights_df_module import flights_processing`

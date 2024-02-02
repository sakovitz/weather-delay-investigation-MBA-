Functions Documentarion
=======================

func_metar_df_module
--------------------
`metar_processing()` - A function that returns a Pandas DataFrame containing METAR information organized into individual columns.

DataFrame Columns:
- **station_id:** Station Identifier ICAO (ex. SBGR)
- **date_time:** Date and time of the observation, datetime object in ZULU
- **wind_direction:** Direction the wind is coming from, measured in degrees
- **wind_speed:** Wind speed, measured in knots
- **wind_gust:** Wind gust, measured in knots
- **visibility:** Visibility distance, measured in meters
- **current_wx1:** Current weather (1 of 3) (ex. -RA)
- **current_wx2:** Current weather (2 of 3)
- **current_wx3:** Current weather (3 of 3)
- **low_cloud_type:** Low-level sky cover (ex. FEW)
- **low_cloud_level:** Height of low-level sky cover, measured in feet
- **medium_cloud_type:** Medium-level sky cover (ex. OVC)
- **medium_cloud_level:** Height of medium-level sky cover, measured in feet
- **high_cloud_type:** High-level sky cover (ex. FEW)
- **high_cloud_level:** Height of high-level sky cover, measured in feet
- **highest_cloud_type:** Highest-level Sky cover (ex. CLR)
- **highest_cloud_level:** Height of highest-level sky cover, measured in feet
- **air_temperature:** Temperature, measured in degrees Celsius
- **dew_point_temperature:** ew point, measured in degrees Celsius
- **altimeter:** Altimeter value, measured in inches of mercury (ex. 29.91)
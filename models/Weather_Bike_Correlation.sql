{{ config(materialized='table') }}

WITH weather_bike_CTE AS(

SELECT t.*,
       w.*

FROM {{ ref('trip_fact') }} t
LEFT JOIN {{ ref('daily_weather') }} w
ON t.trip_date = w.daily_weather
)

SELECT * FROM weather_bike_CTE
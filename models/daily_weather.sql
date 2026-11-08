WITH Daily_Weather_CTE AS (

select  

DATE(TIME) as daily_weather,
WEATHER,
Temp,
pressure,
humidity,
clouds
FROM {{ source('DEMO', 'WEATHER') }}
),
Daily_Weather_agg_CTE AS (
SELECT daily_weather
      ,WEATHER
      ,round(avg(Temp),2) AS AVG_TEMP
      ,round(avg(pressure),2)  AS AVG_PRESSURE
      ,round(avg(humidity),2)  AS AVG_HUMIDITY
      ,round(avg(clouds),2)  AS AVG_CLOUD
 FROM Daily_Weather_CTE
GROUP BY daily_weather,WEATHER
QUALIFY ROW_NUMBER() OVER(Partition by daily_weather ORDER BY COUNT(WEATHER) DESC) = 1

)

SELECT * FROM Daily_Weather_agg_CTE
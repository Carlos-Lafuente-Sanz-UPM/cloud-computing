-- CONSULTA 1: Exploración inicial (según PDF - primeras 100 filas)
SELECT TOP 100 *
FROM OPENROWSET(
    BULK 'https://datalakeogvdlabs.dfs.core.windows.net/fsogvd/user/NYCTripSmall.parquet',
    FORMAT='PARQUET'
) AS [result]

-- CONSULTA 2: Sumatorio de carreras por año (adaptado según datos disponibles)
SELECT 
    YEAR(lpep_pickup_datetime) as pickup_year,
    COUNT(*) as total_trips,
    ROUND(SUM(total_amount), 2) as total_revenue,
    ROUND(AVG(total_amount), 2) as avg_fare,
    ROUND(AVG(trip_distance), 2) as avg_distance
FROM OPENROWSET(
    BULK 'https://datalakeogvdlabs.dfs.core.windows.net/fsogvd/user/NYCTripSmall.parquet',
    FORMAT='PARQUET'
) AS [result]
WHERE total_amount > 0 AND trip_distance > 0
GROUP BY YEAR(lpep_pickup_datetime)
ORDER BY pickup_year

-- CONSULTA 3: Análisis por tipo de pago (serverless SQL)
SELECT 
    payment_type,
    COUNT(*) as trip_count,
    ROUND(AVG(total_amount), 2) as avg_amount,
    ROUND(SUM(total_amount), 2) as total_revenue,
    ROUND(AVG(trip_distance), 2) as avg_distance
FROM OPENROWSET(
    BULK 'https://datalakeogvdlabs.dfs.core.windows.net/fsogvd/user/NYCTripSmall.parquet',
    FORMAT='PARQUET'
) AS [result]
WHERE total_amount > 0
GROUP BY payment_type
ORDER BY trip_count DESC

-- CONSULTA 4: Top 20 rutas más populares (según PDF)
SELECT TOP 20
    PULocationID,
    DOLocationID,
    COUNT(*) as trip_count,
    ROUND(AVG(trip_distance), 2) as avg_distance,
    ROUND(AVG(total_amount), 2) as avg_fare
FROM OPENROWSET(
    BULK 'https://datalakeogvdlabs.dfs.core.windows.net/fsogvd/user/NYCTripSmall.parquet',
    FORMAT='PARQUET'
) AS [result]
WHERE PULocationID IS NOT NULL AND DOLocationID IS NOT NULL
GROUP BY PULocationID, DOLocationID
ORDER BY trip_count DESC

-- CONSULTA 5: Análisis temporal detallado por hora
SELECT 
    DATEPART(hour, lpep_pickup_datetime) as pickup_hour,
    COUNT(*) as trip_count,
    ROUND(AVG(total_amount), 2) as avg_fare,
    ROUND(SUM(total_amount), 2) as hourly_revenue
FROM OPENROWSET(
    BULK 'https://datalakeogvdlabs.dfs.core.windows.net/fsogvd/user/NYCTripSmall.parquet',
    FORMAT='PARQUET'
) AS [result]
WHERE total_amount > 0 AND lpep_pickup_datetime IS NOT NULL
GROUP BY DATEPART(hour, lpep_pickup_datetime)
ORDER BY pickup_hour
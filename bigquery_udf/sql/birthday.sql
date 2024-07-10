CREATE OR REPLACE FUNCTION `udfs.birthday`(d ANY TYPE, f ANY TYPE, t STRING) RETURNS STRING AS (
IF
    (d IS NULL
      OR TRIM(CAST(d AS STRING))='', NULL, FORMAT(CASE
              WHEN t = 'day' THEN '%02d'
              WHEN t = 'month' THEN '%02d'
              WHEN t = 'year' THEN '%04d'
            ELSE
            NULL
          END
            ,
            CASE
              WHEN t = 'day' THEN EXTRACT(DAY FROM PARSE_DATE( IFNULL(NULLIF(CAST(f AS STRING), ""), "%Y-%m-%d"), TRIM(CAST(d AS STRING))))
              WHEN t = 'month' THEN EXTRACT(MONTH FROM PARSE_DATE( IFNULL(NULLIF(CAST(f AS STRING), ""), "%Y-%m-%d"), TRIM(CAST(d AS STRING))))
              WHEN t = 'year' THEN EXTRACT(YEAR FROM PARSE_DATE( IFNULL(NULLIF(CAST(f AS STRING), ""), "%Y-%m-%d"), TRIM(CAST(d AS STRING))))
            ELSE
            NULL
          END
            ))
);

CREATE MATERIALIZED VIEW aggregate_by_measure AS
  SELECT
    measure_uri,
    source,
    type,
    version,
    SUM(value) as value
  FROM event INNER JOIN measure USING(measure_uri)
  GROUP BY measure_uri, source, type, version
  ORDER BY measure_uri;

CREATE MATERIALIZED VIEW aggregate_by_country AS
  SELECT
    country_uri,
    country_code,
    country_name,
    continent_code,
    SUM(value) as value
  FROM event LEFT JOIN country USING(country_uri)
  GROUP BY country_uri, country_code, country_name, continent_code
  ORDER BY country_uri;

CREATE MATERIALIZED VIEW aggregate_by_measure_country AS
  SELECT
    measure_uri,
    source,
    type,
    version,
    country_uri,
    country_code,
    country_name,
    continent_code,
    SUM(value) as value
  FROM event
    INNER JOIN measure USING(measure_uri)
    LEFT JOIN country USING(country_uri)
  GROUP BY measure_uri, source, type, version, country_uri, country_code, country_name, continent_code
  ORDER BY measure_uri, country_uri;

CREATE MATERIALIZED VIEW aggregate_by_country_measure AS
  SELECT
    country_uri,
    country_code,
    country_name,
    continent_code,
    measure_uri,
    source,
    type,
    version,
    SUM(value) as value
  FROM event
    INNER JOIN measure USING(measure_uri)
    LEFT JOIN country USING(country_uri)
  GROUP BY country_uri, country_code, country_name, continent_code, measure_uri, source, type, version
  ORDER BY country_uri, measure_uri;

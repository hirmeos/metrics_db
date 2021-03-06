CREATE TABLE continent(
  continent_code char(2) PRIMARY KEY NOT NULL,
  continent_name varchar(255) NOT NULL
);

CREATE TABLE country(
  country_uri char(22) PRIMARY KEY NOT NULL,
  country_code char(2) NOT NULL,
  country_name text NOT NULL,
  continent_code char(2) NOT NULL REFERENCES continent(continent_code)
);

CREATE TABLE locale(
  locale_code char(5) PRIMARY KEY NOT NULL,
  locale_name text NOT NULL
);

CREATE TABLE type(
  type varchar(255) PRIMARY KEY NOT NULL
);

CREATE TABLE source(
  source text PRIMARY KEY NOT NULL
);

CREATE TABLE namespace(
  namespace text PRIMARY KEY NOT NULL
);

CREATE TABLE version(
  version varchar(255) PRIMARY KEY NOT NULL
);

CREATE TABLE measure(
  measure_uri text PRIMARY KEY NOT NULL,
  namespace text NOT NULL REFERENCES namespace(namespace),
  source text NOT NULL REFERENCES source(source),
  version varchar(255) NOT NULL REFERENCES version(version),
  type varchar(255) NOT NULL REFERENCES type(type)
);

CREATE TABLE measure_description(
  measure_uri text NOT NULL,
  locale_code char(5) NOT NULL,
  description text NOT NULL,
  PRIMARY KEY(measure_uri, locale_code)
);

CREATE TABLE event(
  event_id uuid PRIMARY KEY NOT NULL,
  work_uri text NOT NULL,
  measure_uri text NOT NULL REFERENCES measure(measure_uri),
  timestamp timestamp with time zone NOT NULL,
  value integer NOT NULL,
  event_uri text NULL,
  country_uri char(22) NULL REFERENCES country(country_uri),
  uploader_uri text NOT NULL
);
CREATE UNIQUE INDEX event_uri_measure_timestamp_event_uri_null_key ON event (work_uri, measure_uri, timestamp, event_uri)
WHERE (country_uri IS NOT NULL AND event_uri IS NOT NULL)
  OR (country_uri IS NULL AND event_uri IS NULL)
  OR (country_uri IS NULL AND event_uri IS NOT NULL);
CREATE UNIQUE INDEX event_uri_measure_timestamp_country_uri_null_key ON event (work_uri, measure_uri, timestamp, country_uri)
WHERE (country_uri IS NOT NULL AND event_uri IS NOT NULL)
  OR (country_uri IS NULL AND event_uri IS NULL)
  OR (country_uri IS NOT NULL AND event_uri IS NULL);
CREATE UNIQUE INDEX event_uri_measure_timestamp_null_key ON event (work_uri, measure_uri, timestamp)
WHERE country_uri IS NULL AND event_uri IS NULL;

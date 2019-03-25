CREATE EXTENSION uri;

CREATE TABLE continent(
  continent_code char(2) PRIMARY KEY NOT NULL,
  continent_name varchar(255) NOT NULL
);

CREATE TABLE country(
  country_uri uri PRIMARY KEY NOT NULL,
  country_code char(2) NOT NULL,
  country_name varchar(255) NOT NULL,
  continent_code char(2) NOT NULL REFERENCES continent(continent_code)
);

CREATE TABLE type(
  type varchar(255) PRIMARY KEY NOT NULL
);

CREATE TABLE source(
  source varchar(255) PRIMARY KEY NOT NULL
);

CREATE TABLE namespace(
  namespace varchar(255) PRIMARY KEY NOT NULL
);

CREATE TABLE version(
  version varchar(255) PRIMARY KEY NOT NULL
);

CREATE TABLE uploader(
  uploader varchar(255) PRIMARY KEY NOT NULL,
  uploader_email varchar(255) NOT NULL
);

CREATE TABLE namespace_uploader(
  namespace varchar(255) NOT NULL REFERENCES namespace(namespace),
  uploader varchar(255) NOT NULL REFERENCES uploader(uploader),
  PRIMARY KEY(namespace, uploader)
);

CREATE TABLE measure(
  measure_uri uri PRIMARY KEY NOT NULL,
  namespace varchar(255) NOT NULL REFERENCES namespace(namespace),
  source varchar(255) NOT NULL REFERENCES source(source),
  version varchar(255) NOT NULL REFERENCES version(version),
  type varchar(255) NOT NULL REFERENCES type(type)
);

CREATE TABLE event(
  event_id uuid PRIMARY KEY NOT NULL,
  work_uri uri NOT NULL,
  measure_uri uri NOT NULL REFERENCES measure(measure_uri),
  timestamp timestamp with time zone NOT NULL,
  value integer NOT NULL,
  event_uri uri NULL,
  country_uri uri NULL REFERENCES country(country_uri),
  uploader varchar(255) NOT NULL REFERENCES uploader(uploader),
  UNIQUE(work_uri, measure_uri, timestamp, event_uri, country_uri)
);
CREATE UNIQUE INDEX event_uri_measure_timestamp_country_uri_null_key ON event (work_uri, measure_uri, event_uri, timestamp)
WHERE country_uri IS NULL;


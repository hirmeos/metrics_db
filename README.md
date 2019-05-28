# Metrics Database
Postgres database of publication usage statistics

## Instructions

Start a database instance:
`
docker run --name metrics_db -e POSTGRES_PASSWORD=mysecretpassword -e POSTGRES_DB=metrics_db -e POSTGRES_USER=obp -d openbookpublishers/metrics_db
`

## Schema
![Metrics ERD](./metrics.png)

NB. All attributes, except `measure_description/description`, that in the diagram are displayed with data type `text` are actually of type `uri`. They are displayed as `text` due to limitations with the visualisation software representing custom types. See *URI Data Type* below for more information about the custom data type `uri`.

### URI Data Type

Attributes that represent a URI are defined with the custom type `uri`, provided with the [petere/pguri][1] extension. Apart from input validation there are a few useful functions provided by the function (e.g. `select uri_path(work_uri) ...`), check the extension's [readme file][2] for the full list.

[1]: https://github.com/petere/pguri "uri type extension"
[2]: https://github.com/petere/pguri/blob/master/README.md "uri type extension README file"

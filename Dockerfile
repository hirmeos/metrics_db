FROM postgres:11

# install PostgreSQL uri data type extension
WORKDIR /tmp/src
RUN apt-get update && \
    apt-get install -y git \
                       autoconf \
                       libtool \
                       make \
                       liburiparser-dev \
                       pkg-config \
                       postgresql-server-dev-${PG_MAJOR}
RUN git clone git://github.com/petere/pguri
WORKDIR /tmp/src/pguri
RUN make
RUN make install
# clean up
WORKDIR /
RUN rm -rf /tmp/src

# schema and default population
COPY ./sql/* /docker-entrypoint-initdb.d/

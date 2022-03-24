FROM postgres:10

ENV DEFAULT_TIMEZONE UTC
# Mandatory nowdays with PG 10
ENV WAL_LEVEL logical

# Add wale script
COPY setup-wale.sh /docker-entrypoint-initdb.d/

# Healthcheck to make sure container is ready
HEALTHCHECK CMD pg_isready -U $POSTGRES_USER -d $POSTGRES_DB || exit 1

# Add and configure entrypoint and command
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["postgres"]

VOLUME ["/var/run/postgresql", "/usr/share/postgresql/", "/var/lib/postgresql/data", "/tmp", "/etc/wal-e.d/env"]

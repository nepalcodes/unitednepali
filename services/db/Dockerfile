FROM postgres:10

# Create schema and seed data on init, order ran is alphabetically
ADD create_schema.sql /docker-entrypoint-initdb.d
ADD seed_data.sql /docker-entrypoint-initdb.d

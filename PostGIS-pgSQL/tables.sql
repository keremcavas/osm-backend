CREATE TABLE IF NOT EXISTS users_locations(
    osm_id serial PRIMARY KEY,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    time bigint,	
    clientId INT,
    trackingId INT,
    geometry GEOMETRY	
);

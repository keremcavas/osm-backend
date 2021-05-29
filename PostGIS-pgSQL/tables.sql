CREATE TABLE IF NOT EXISTS users_locations(
    	osm_id serial PRIMARY KEY,
    	latitude DOUBLE PRECISION,
    	longitude DOUBLE PRECISION,
    	time bigint,	
    	clientId INT,
    	trackingId INT,
    	geometry GEOMETRY	
);
CREATE TABLE IF NOT EXISTS user_routes(
	osm_id serial PRIMARY KEY,
	name TEXT,
	ref TEXT,
	type TEXT,
	class TEXT,
	z_order INT,
	clientId INT,
    	trackingId INT,
	geometry GEOMETRY
);

CREATE TABLE IF NOT EXISTS users_routes(
	osm_id serial PRIMARY KEY,
	name TEXT,
	ref TEXT,
	type TEXT,
	class TEXT,
	z_order INT,
	clientId INT,
  	trackingId INT,
	route_color TEXT,
	geometry GEOMETRY
);
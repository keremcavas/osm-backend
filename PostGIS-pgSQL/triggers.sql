-- users_locations table set geometry column trigger

CREATE OR REPLACE FUNCTION make_geom_func()
RETURNS trigger AS $$
DECLARE
geo geometry;
lat NUMERIC;
lon NUMERIC;
BEGIN
SELECT latitude INTO lat FROM users_locations WHERE osm_id = NEW.osm_id;
SELECT longitude INTO lon FROM users_locations WHERE osm_id = NEW.osm_id;
SELECT ST_SetSRID(ST_Point(lon,lat),4326) INTO geo;
UPDATE users_locations SET geometry = geo WHERE osm_id = NEW.osm_id;
RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER geom_trigger AFTER INSERT ON users_locations
FOR EACH ROW
EXECUTE PROCEDURE make_geom_func();

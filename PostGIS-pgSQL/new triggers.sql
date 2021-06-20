CREATE OR REPLACE FUNCTION fill_color()
RETURNS trigger AS $$
DECLARE
color text; color1 text; color2 text; color3 text;
client_count int;
BEGIN
SELECT COUNT(osm_id) INTO client_count FROM users_routes WHERE clientid = NEW.clientid;
IF client_count = 1 THEN
SELECT floor(random() * 256)::text INTO color1;
SELECT floor(random() * 256)::text INTO color2;
SELECT floor(random() * 256)::text INTO color3;
color := color1 || ' ' || color2 || ' ' || color3;
ELSE
SELECT route_color INTO color FROM users_routes WHERE clientid = NEW.clientid ORDER BY osm_id LIMIT 1;
END IF;
UPDATE users_routes SET route_color = color WHERE osm_id = NEW.osm_id;
RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER color_trigger AFTER INSERT ON users_routes
FOR EACH ROW
EXECUTE PROCEDURE fill_color();

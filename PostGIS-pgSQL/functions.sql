CREATE OR REPLACE FUNCTION add_route(cId INT, tId INT)
RETURNS void AS $$
DECLARE
line geometry;
BEGIN
CREATE TEMP TABLE temp_table
AS SELECT geometry FROM users_locations WHERE trackingid=tId AND clientId=cId GROUP BY geometry, time ORDER BY time;
SELECT ST_Transform(ST_MakeLine(geometry),3857) INTO line FROM temp_table;
DROP TABLE temp_table;
INSERT INTO users_routes(name,ref,type,class,z_order,clientId,trackingId,geometry)
VALUES('Rota',null,'motorway','motorways',39,cId,tId,line);
END;
$$ LANGUAGE 'plpgsql';

-- find 5 closest routes to the given location point
CREATE OR REPLACE FUNCTION get_routes_near_point(lat DOUBLE PRECISION, lon DOUBLE PRECISION)
RETURNS TABLE (osm_id BIGINT,
			   clientId INT,
			   trackingId INT,
			   time1 BIGINT
) AS 
$$
DECLARE
	route RECORD;
BEGIN
	FOR route IN (
		SELECT 
			r.osm_id,
			r.trackingId,
			r.clientId
		FROM users_routes r
		ORDER BY ST_Distance(ST_Transform(r.geometry, 4326), ST_SetSRID(ST_MakePoint(lon, lat), 4326))
		LIMIT 5
	) LOOP
		osm_id := route.osm_id;
		clientId := route.clientID;
		trackingId := route.trackingID;
		SELECT l.time INTO time1 FROM users_locations l WHERE route.trackingId = l.trackingId LIMIT 1;
		RETURN NEXT;
	END LOOP;
END;
$$ LANGUAGE 'plpgsql';

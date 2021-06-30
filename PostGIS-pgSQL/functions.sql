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
RETURNS TABLE (clientId INT,
               trackingId INT,
               "time" BIGINT
) AS 
$$
DECLARE
    route RECORD;
BEGIN
    FOR route IN (
        SELECT 
            r.trackingId,
            r.clientId
        FROM users_routes r
        ORDER BY ST_Distance(ST_Transform(r.geometry, 4326), ST_SetSRID(ST_MakePoint(lon, lat), 4326))
        LIMIT 5
    ) LOOP
        clientId := route.clientID;
        trackingId := route.trackingID;
        SELECT l.time INTO time FROM users_locations l WHERE route.trackingId = l.trackingId LIMIT 1;
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';

-- find 5 closest routes to the given location point and time interval
CREATE OR REPLACE FUNCTION get_routes_near_point_time_inteval(lat DOUBLE PRECISION, lon DOUBLE PRECISION, startTime BIGINT, endTime BIGINT)
RETURNS TABLE (clientId INT,
               trackingId INT,
               "time" BIGINT
) AS 
$$
DECLARE
    route RECORD;
BEGIN
    FOR route IN (
        SELECT 
            r.trackingId,
            r.clientId
        FROM users_routes r
        ORDER BY ST_Distance(ST_Transform(r.geometry, 4326), ST_SetSRID(ST_MakePoint(lon, lat), 4326))
        LIMIT 5
    ) LOOP
        clientId := route.clientID;
        trackingId := route.trackingID;
        SELECT l.time INTO time FROM users_locations l WHERE route.trackingId = l.trackingId LIMIT 1;
        IF time >= startTime AND time <= endTime THEN
            RETURN NEXT;
        END IF;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION get_routes_inside_area(
        lat1 DOUBLE PRECISION, lon1 DOUBLE PRECISION,
        lat2 DOUBLE PRECISION, lon2 DOUBLE PRECISION)
RETURNS TABLE (
        clientId INT,
        trackingId INT,
        "time" BIGINT
) AS
$$
DECLARE
    route RECORD;
BEGIN
    FOR route IN (
        SELECT r.trackingId, r.clientId
        FROM users_routes r
        WHERE ST_Intersects(ST_Transform(r.geometry, 4326), ST_MakeEnvelope(lon1, lat1, lon2, lat2, 4326))
    ) LOOP 
        clientId := route.clientID;
        trackingId := route.trackingID;
        SELECT l.time INTO time FROM users_locations l WHERE route.trackingId = l.trackingId LIMIT 1;
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION get_routes_inside_area_time_interval(
        lat1 DOUBLE PRECISION, lon1 DOUBLE PRECISION,
        lat2 DOUBLE PRECISION, lon2 DOUBLE PRECISION,
        startTime BIGINT, endTime BIGINT)
RETURNS TABLE (
        clientId INT,
        trackingId INT,
        "time" BIGINT
) AS
$$
DECLARE
    route RECORD;
BEGIN
    FOR route IN (
        SELECT r.trackingId, r.clientId
        FROM users_routes r
        WHERE ST_Intersects(ST_Transform(r.geometry, 4326), ST_MakeEnvelope(lon1, lat1, lon2, lat2, 4326))
    ) LOOP 
        clientId := route.clientID;
        trackingId := route.trackingID;
        SELECT l.time INTO time FROM users_locations l WHERE route.trackingId = l.trackingId LIMIT 1;
        IF time >= startTime AND time <= endTime THEN
            RETURN NEXT;
        END IF;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';

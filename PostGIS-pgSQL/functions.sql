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

-- find routes inside given rectangular area
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

-- find routes inside given rectangular area and time interval
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

-- find 5 closest routes to the given location point of specific user
CREATE OR REPLACE FUNCTION get_routes_near_point_of_client(lat DOUBLE PRECISION, lon DOUBLE PRECISION, clnt INT)
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
        WHERE r.clientid = clnt
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

-- find 5 closest routes to the given location point and time interval of specific user
CREATE OR REPLACE FUNCTION get_routes_near_point_time_inteval_of_client(lat DOUBLE PRECISION, lon DOUBLE PRECISION, startTime BIGINT, endTime BIGINT, clnt INT)
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
        WHERE r.clientid = clnt
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

-- find routes of specific user inside given rectangular area
CREATE OR REPLACE FUNCTION get_routes_inside_area_of_client(
        lat1 DOUBLE PRECISION, lon1 DOUBLE PRECISION,
        lat2 DOUBLE PRECISION, lon2 DOUBLE PRECISION,
        clnt INT)
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
        WHERE ST_Intersects(ST_Transform(r.geometry, 4326), ST_MakeEnvelope(lon1, lat1, lon2, lat2, 4326)) AND r.clientid = clnt
    ) LOOP 
        clientId := route.clientID;
        trackingId := route.trackingID;
        SELECT l.time INTO time FROM users_locations l WHERE route.trackingId = l.trackingId LIMIT 1;
        RETURN NEXT;
    END LOOP;
END;
$$ LANGUAGE 'plpgsql';

-- find routes of specific user inside given rectangular area and time interval
CREATE OR REPLACE FUNCTION get_routes_inside_area_time_interval_of_client(
        lat1 DOUBLE PRECISION, lon1 DOUBLE PRECISION,
        lat2 DOUBLE PRECISION, lon2 DOUBLE PRECISION,
        startTime BIGINT, endTime BIGINT,
        clnt INT)
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
        WHERE ST_Intersects(ST_Transform(r.geometry, 4326), ST_MakeEnvelope(lon1, lat1, lon2, lat2, 4326)) AND r.clientid = clnt
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


CREATE OR REPLACE FUNCTION get_closest_route("point" GEOMETRY)
RETURNS GEOMETRY AS
$$
BEGIN
    RETURN (
        SELECT * FROM ST_Transform(
            (SELECT l.way
            FROM osm_line l
            ORDER BY St_Distance(ST_Transform(point, 4326), ST_Transform(l.way, 4326)) ASC
            LIMIT 1)
        , 4326)
    );
END;
$$ LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION match_route(cId INTEGER, tId INTEGER)
RETURNS VOID AS $$
DECLARE
    RAW_POINTS GEOMETRY[];
    raw_points_size INTEGER;
    current_start_point GEOMETRY;
    current_end_point GEOMETRY;
    current_line GEOMETRY;
    FINAL_LINES GEOMETRY[];
    temp_line GEOMETRY;
    line GEOMETRY;
    start_point float8;
    end_point float8;
    temp_point float8;
BEGIN
    RAW_POINTS := ARRAY(SELECT l.geometry FROM users_locations l WHERE l.trackingid = tId);
    raw_points_size := array_upper(RAW_POINTS, 1);
    current_line := get_closest_route(RAW_POINTS[1]);
    current_start_point := ST_ClosestPoint(RAW_POINTS[1], current_line);
    FOR i IN 2 .. raw_points_size - 1
    LOOP
        temp_line := get_closest_route(RAW_POINTS[i]);
        IF NOT ST_Equals(current_line, temp_line) THEN
            current_end_point := ST_ClosestPoint(temp_line, current_line);
            start_point := ST_LineLocatePoint(current_line, current_start_point);
            end_point := ST_LineLocatePoint(current_line, current_end_point);
            IF start_point > end_point THEN
                temp_point := start_point;
                start_point := end_point;
                end_point := temp_point;
            END IF;
            FINAL_LINES := array_append(FINAL_LINES, ST_LineSubstring(current_line, start_point, end_point));
            current_line := temp_line;
            current_start_point := current_end_point;
        END IF;
    END LOOP;
    current_end_point := ST_ClosestPoint(RAW_POINTS[raw_points_size], current_line);
    start_point := ST_LineLocatePoint(current_line, current_start_point);
    end_point := ST_LineLocatePoint(current_line, current_end_point);
    IF start_point > end_point THEN
        temp_point := start_point;
        start_point := end_point;
        end_point := temp_point;
    END IF;
    FINAL_LINES := array_append(FINAL_LINES, ST_LineSubstring(current_line, start_point, end_point));
    SELECT * INTO line FROM ST_LineMerge(ST_Multi(ST_Collect(FINAL_LINES)));
    INSERT INTO users_routes(name,ref,type,class,z_order,clientId,trackingId,geometry)
    VALUES('Rota', null, 'motorway', 'motorways', 39, cId, tId, line);
END;
$$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION add_route(cId INT, tId INT)
RETURNS void AS $$
DECLARE
line geometry;
BEGIN
CREATE TEMP TABLE temp_table
AS SELECT geometry FROM users_locations WHERE trackingid=tId AND clientId=cId GROUP BY geometry, time ORDER BY time;
SELECT ST_Transform(ST_MakeLine(geometry),3857) INTO line FROM temp_table;
DROP TABLE temp_table;
INSERT INTO users_routes(name,ref,type,class,z_order,clientId,trackingid,geometry)
VALUES('Rota',null,'motorway','motorways',39,cId,tId,line);
END;
$$ LANGUAGE 'plpgsql';

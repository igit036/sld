DROP TABLE IF EXISTS "aero-poly";
CREATE TABLE "aero-poly" AS ( 
  SELECT osm_id, way as geom,aeroway 
  FROM planet_osm_polygon
  WHERE "aeroway" IN ('apron','runway','taxiway','helipad')
  ORDER BY z_order ASC );
ALTER TABLE "aero-poly" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "aero-poly_geom_idx" ON "aero-poly" USING gist (geom);

DROP TABLE IF EXISTS "agriculture";
CREATE TABLE "agriculture" AS ( 
  SELECT osm_id, way as geom,landuse FROM planet_osm_polygon
  WHERE "landuse" IN ('allotments','farm','farmland','farmyard',
                      'orchard','vineyard')
  ORDER BY z_order ASC );
ALTER TABLE "agriculture" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "agriculture_geom_idx" ON "agriculture" USING gist (geom);

DROP TABLE IF EXISTS "amenity-areas";
CREATE TABLE "amenity-areas" AS (
  SELECT osm_id, way as geom,amenity FROM planet_osm_polygon
  WHERE amenity IN ('hospital','college','school','university') 
  AND (building IS NULL OR building NOT IN ('no'))
);
ALTER TABLE "amenity-areas" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "amenity-areas_geom_idx" ON "amenity-areas" USING gist (geom);

DROP TABLE IF EXISTS "beach";
CREATE TABLE "beach" AS ( 
  SELECT osm_id, way as geom,"natural"
  FROM planet_osm_polygon
  WHERE "natural" = 'beach'
  ORDER BY z_order ASC
);
ALTER TABLE "beach" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "beach_geom_idx" ON "beach" USING gist (geom);

DROP TABLE IF EXISTS "building";
CREATE TABLE "building" AS ( 
  SELECT osm_id, way as geom,building,aeroway,"addr:housenumber" as housenumber,"name"
  FROM planet_osm_polygon
  WHERE ("building" IS NOT NULL
  AND "building" != 'no')
  OR "aeroway" IN ('terminal')
  ORDER BY z_order ASC 
);
ALTER TABLE "building" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "building_geom_idx" ON "building" USING gist (geom);

DROP TABLE IF EXISTS "forest";
CREATE TABLE "forest" AS ( SELECT osm_id, way as geom, "landuse", "leisure", "natural", (CASE 
            WHEN way_area >= 10000000 THEN 'huge'
            WHEN way_area >= 1000000 THEN 'large'
            WHEN way_area >= 100000 THEN 'medium'
            ELSE 'small' END) AS size FROM planet_osm_polygon
          WHERE "natural" IN ('wood') OR "landuse" IN ('forest','wood')
          ORDER BY z_order ASC );
ALTER TABLE "forest" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "forest_geom_idx" ON "forest" USING gist (geom);

DROP TABLE IF EXISTS "grass";
CREATE TABLE "grass" AS ( SELECT osm_id, way as geom,landuse, (CASE 
            WHEN way_area >= 10000000 THEN 'huge'
            WHEN way_area >= 1000000 THEN 'large'
            WHEN way_area >= 100000 THEN 'medium'
            ELSE 'small' END) AS size FROM planet_osm_polygon
          WHERE "landuse" IN ('grass', 'greenfield', 'meadow')
            OR "natural" IN ('fell', 'heath', 'scrub')
          ORDER BY z_order ASC 
        );
ALTER TABLE "grass" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "grass_geom_idx" ON "grass" USING gist (geom);

DROP TABLE IF EXISTS "highway-label";
CREATE TABLE "highway-label" AS (
  SELECT osm_id, way as geom,"name",highway, 
    CASE WHEN oneway IN ('yes','true','1') THEN 'yes'::text END AS oneway
  FROM planet_osm_line
  WHERE "highway" IS NOT NULL
  AND ("name" IS NOT NULL OR "oneway" IS NOT NULL)
  ORDER BY z_order ASC 
);
ALTER TABLE "highway-label" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "highway-label_geom_idx" ON "highway-label" USING gist (geom);

DROP TABLE IF EXISTS "park";
CREATE TABLE "park" AS ( SELECT osm_id, way as geom, landuse, leisure, "name", (CASE 
            WHEN way_area >= 10000000 THEN 'huge'
            WHEN way_area >= 1000000 THEN 'large'
            WHEN way_area >= 100000 THEN 'medium'
            ELSE 'small' END) AS size FROM planet_osm_polygon
          WHERE "leisure" IN ('dog_park', 'golf_course', 'pitch', 'park',
            'playground', 'garden', 'common')
            OR "landuse" IN ('allotments', 'cemetery','recreation_ground', 'village_green')
          ORDER BY z_order asc );
ALTER TABLE "park" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "park_geom_idx" ON "park" USING gist (geom);

DROP TABLE IF EXISTS "parking-area";
CREATE TABLE "parking-area" AS (
  SELECT osm_id, way as geom,amenity 
  FROM planet_osm_polygon
  WHERE amenity = 'parking'
);
ALTER TABLE "parking-area" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "parking-area_geom_idx" ON "parking-area" USING gist (geom);

DROP TABLE IF EXISTS "placenames-medium";
CREATE TABLE "placenames-medium" AS ( 
  SELECT osm_id, way as geom,place,"name"
  FROM planet_osm_point
  WHERE place IN ('city','metropolis','town','large_town','small_town')
);
ALTER TABLE "placenames-medium" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "placenames-medium_geom_idx" ON "placenames-medium" USING gist (geom);

DROP TABLE IF EXISTS "route-bridge-0";
CREATE TABLE "route-bridge-0" AS ( 
  SELECT osm_id, way as geom,highway,railway,aeroway,tunnel
  FROM planet_osm_line
  WHERE ( "highway" IS NOT NULL
  OR "railway" IS NOT NULL
  OR "aeroway" IN ('apron','runway','taxiway') )
  AND bridge IN ('yes','true','1','viaduct')
  AND (layer IS NULL OR layer = '0')
  ORDER BY z_order asc
 );
ALTER TABLE "route-bridge-0" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-bridge-0_geom_idx" ON "route-bridge-0" USING gist (geom);

DROP TABLE IF EXISTS "route-bridge-1";
CREATE TABLE "route-bridge-1" AS ( 
  SELECT osm_id, way as geom,highway,railway,aeroway,tunnel
  FROM planet_osm_line
  WHERE ( "highway" IS NOT NULL
  OR "railway" IS NOT NULL
  OR "aeroway" IN ('apron','runway','taxiway') )
  AND bridge IN ('yes','true','1','viaduct')
  AND layer = '1'
  ORDER BY z_order asc
 );
ALTER TABLE "route-bridge-1" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-bridge-1_geom_idx" ON "route-bridge-1" USING gist (geom);

DROP TABLE IF EXISTS "route-bridge-2";
CREATE TABLE "route-bridge-2" AS ( 
  SELECT osm_id, way as geom,highway,railway,aeroway,tunnel
  FROM planet_osm_line
  WHERE ( "highway" IS NOT NULL
  OR "railway" IS NOT NULL
  OR "aeroway" IN ('apron','runway','taxiway') )
  AND bridge IN ('yes','true','1','viaduct')
  AND layer = '2'
  ORDER BY z_order asc
 );
ALTER TABLE "route-bridge-2" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-bridge-2_geom_idx" ON "route-bridge-2" USING gist (geom);

DROP TABLE IF EXISTS "route-bridge-3";
CREATE TABLE "route-bridge-3" AS ( 
  SELECT osm_id, way as geom,highway,railway,aeroway,tunnel
  FROM planet_osm_line
  WHERE ( "highway" IS NOT NULL
  OR "railway" IS NOT NULL
  OR "aeroway" IN ('apron','runway','taxiway') )
  AND bridge IN ('yes','true','1','viaduct')
  AND layer = '3'
  ORDER BY z_order asc
 );
ALTER TABLE "route-bridge-3" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-bridge-3_geom_idx" ON "route-bridge-3" USING gist (geom);

DROP TABLE IF EXISTS "route-bridge-4";
CREATE TABLE "route-bridge-4" AS ( 
  SELECT osm_id, way as geom,highway,railway,aeroway,tunnel
  FROM planet_osm_line
  WHERE ( "highway" IS NOT NULL
  OR "railway" IS NOT NULL
  OR "aeroway" IN ('apron','runway','taxiway') )
  AND bridge IN ('yes','true','1','viaduct')
  AND layer = '4'
  ORDER BY z_order asc
 );
ALTER TABLE "route-bridge-4" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-bridge-4_geom_idx" ON "route-bridge-4" USING gist (geom);

DROP TABLE IF EXISTS "route-bridge-5";
CREATE TABLE "route-bridge-5" AS ( 
  SELECT osm_id, way as geom,highway,railway,aeroway,tunnel
  FROM planet_osm_line
  WHERE ( "highway" IS NOT NULL
  OR "railway" IS NOT NULL
  OR "aeroway" IN ('apron','runway','taxiway') )
  AND bridge IN ('yes','true','1','viaduct')
  AND layer = '5'
  ORDER BY z_order asc
 );
ALTER TABLE "route-bridge-5" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-bridge-5_geom_idx" ON "route-bridge-5" USING gist (geom);

DROP TABLE IF EXISTS "route-fill";
CREATE TABLE "route-fill" AS ( 
  SELECT osm_id, way as geom, highway, horse, bicycle, foot, 
    aeroway,
    case when tunnel in ('yes', 'true', '1')
      then 'yes'::text
      else tunnel end as tunnel,
    case when bridge in ('yes','true','1','viaduct')
      then 'yes'::text else bridge end as bridge,
    case when railway in ('spur','siding')
      or (railway='rail' and service in ('spur','siding','yard'))
      then 'spur-siding-yard'::text else railway
      end as railway,
    case when service in 
      ('parking_aisle', 'drive-through', 'driveway')
      then 'INT-minor'::text else service 
      end as service
  FROM planet_osm_line
  WHERE highway IS NOT NULL
    OR aeroway IN ( 'runway','taxiway' )
    OR railway IN ( 'light_rail', 'narrow_gauge', 'funicular',
      'rail', 'subway', 'tram', 'spur', 'siding', 'platform',
      'disused', 'abandoned', 'construction', 'miniature' )
  ORDER BY z_order);
ALTER TABLE "route-fill" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-fill_geom_idx" ON "route-fill" USING gist (geom);

DROP TABLE IF EXISTS "route-line";
CREATE TABLE "route-line" AS ( 
  SELECT osm_id, way as geom,highway,aeroway,
    case when tunnel IN ( 'yes', 'true', '1' ) then 'yes'::text
      else 'no'::text end as tunnel,
    case when service IN ( 'parking_aisle',
      'drive-through','driveway' ) then 'INT-minor'::text
      else service end as service
  FROM planet_osm_line
  WHERE highway in ( 'motorway', 'motorway_link',
    'trunk', 'trunk_link', 'primary', 'primary_link',
    'secondary', 'secondary_link', 'tertiary', 'tertiary_link', 
    'residential', 'unclassified', 'road', 'service',
    'pedestrian', 'raceway', 'living_street' )
  OR "aeroway" IN ('apron','runway','taxiway')
  ORDER BY z_order);
ALTER TABLE "route-line" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-line_geom_idx" ON "route-line" USING gist (geom);

DROP TABLE IF EXISTS "route-tunnels";
CREATE TABLE "route-tunnels" AS ( 
  SELECT osm_id, way as geom,highway FROM planet_osm_line 
  WHERE highway IN
  ( 'motorway', 'motorway_link', 'trunk', 'trunk_link', 
    'primary', 'primary_link', 'secondary', 'secondary_link',
    'tertiary', 'tertiary_link', 'residential', 'unclassified' )
  AND tunnel IN ( 'yes', 'true', '1' )
  ORDER BY z_order );
ALTER TABLE "route-tunnels" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-tunnels_geom_idx" ON "route-tunnels" USING gist (geom);

DROP TABLE IF EXISTS "route-turning-circles";
CREATE TABLE "route-turning-circles" AS ( SELECT osm_id, way as geom, highway FROM planet_osm_point
  WHERE "highway" = 'turning_circle' );
ALTER TABLE "route-turning-circles" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "route-turning-circles_geom_idx" ON "route-turning-circles" USING gist (geom);

DROP TABLE IF EXISTS "water-outline";
CREATE TABLE "water-outline" AS ( 
  SELECT osm_id, way as geom,"natural", "landuse", "waterway", "name"
  FROM planet_osm_polygon
  WHERE "natural" IN ('lake','water')
  OR "waterway" IN ('canal','mill_pond','riverbank')
  OR "landuse" IN ('basin','reservoir','water')
  ORDER BY z_order ASC
);
ALTER TABLE "water-outline" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "water-outline_geom_idx" ON "water-outline" USING gist (geom);

DROP TABLE IF EXISTS water;
CREATE TABLE water AS ( 
  SELECT osm_id, way as geom, "natural", landuse, waterway, "name"
  FROM planet_osm_polygon
  WHERE "natural" IN ('lake','water')
  OR "waterway" IN ('canal','mill_pond','riverbank')
  OR "landuse" IN ('basin','reservoir','water')
  ORDER BY z_order asc
);
ALTER TABLE water ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "water_geom_idx" ON "water" USING gist (geom);

DROP TABLE IF EXISTS "wetland";
CREATE TABLE "wetland" AS (
  SELECT osm_id, way as geom,"natural", "name"
  FROM planet_osm_polygon
  WHERE "natural" IN ('marsh','wetland')
);
ALTER TABLE "wetland" ADD COLUMN OID SERIAL PRIMARY KEY;
CREATE INDEX "wetland_geom_idx" ON "wetland" USING gist (geom);
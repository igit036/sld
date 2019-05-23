# sld
Pack of files (sld, sql, xml) for:
1. create tables from raw osm features (polygone, line, point) in PostGIS database by query - create_tables.sql
2. upload SLD-style to geoserver & create layers - SLD_create.sh & all sld
3. create group layer OSM in geoserver - layergroup.xml

Download & unpack needed data (example):
mkdir osm; cd osm
wget -O northwestern-fed-district-latest.osm.pbf http://download.geofabrik.de/russia/northwestern-fed-district-latest.osm.pbf; wget -O water-polygons-split-3857.zip http://data.openstreetmapdata.com/water-polygons-split-3857.zip; wget -O master.zip https://github.com/igit036/sld/archive/master.zip; wget -O add_ladoga.zip https://github.com/igit036/files/raw/master/add_ladoga.zip (for northwestern-fed-district); wget -O geoserver-2.11.0-vectortiles-plugin.zip http://sourceforge.net/projects/geoserver/files/GeoServer/2.11.0/extensions/geoserver-2.11.0-vectortiles-plugin.zip

<-- source of osm data; all world ocean polygones splitted reprojected in SRID 3857; pack of files (sld, sql, xml); polygon of Ladoga Lake (need for Leningradskaya oblast Add in QGIS); NB! control version of geoserver -->

unzip -o water-polygons-split-3857; unzip -o add_ladoga.zip; unzip -o master.zip; unzip -o geoserver-2.11.0-vectortiles-plugin.zip -d lib; sudo cp -a lib /opt/bitnami/apache-tomcat/webapps/geoserver/WEB-INF

sudo apt-get install osm2pgsql; sudo apt install osmctools; osmconvert northwestern-fed-district-latest.osm.pbf -b=26.4,58.4,35.8,61.4 -o=osm.pbf; osm2pgsql -d osm -U postgres  -W osm/osm.pbf; shp2pgsql -s 3857-I -D osm/water-polygons-split-3857/water_polygons.shp ocean_all |  psql -U postgres -d osm

in Postgresql:
crop_ocean.sql, create_tables.sql

& Restart geoserver & enable geojson in Tile Layers->osm->Tile cashing

Load SLD на geoserver скриптом SLD_create.sh:
cd osm/sld-master; chmod +x SLD_create.sh; sh ./SLD_create.sh

make layergroup:
cd osm/sld-master; curl -v -u admin:geoserver -XPOST -d@layergroup.xml -H "Content-type: text/xml" \ http://IP/geoserver/rest/layergroups
  
#Delete layergroup: curl -v -u admin:geoserver -XDELETE \
  http://IP/geoserver/rest/layergroups/osm
  
  in QGIS - add from osm/scratch.shp (Ladoga Lake) to water, water-outline

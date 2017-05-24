# sld
Pack of files (sld, sql, xml) for:
1. create tables from raw osm features (polygone, line, point) in PostGIS database by query - create_tables.sql
2. upload SLD-style to geoserver & create layers - SLD_create.sh & all sld
3. create group layer OSM in geoserver - layergroup.xml

Download & unpack needed data:
mkdir osm
cd osm
wget -O northwestern-fed-district-latest.osm.pbf http://download.geofabrik.de/russia/northwestern-fed-district-latest.osm.pbf  -- source of osm data
wget -O water-polygons-split-3857.zip http://data.openstreetmapdata.com/water-polygons-split-3857.zip -- all world ocean polygones splitted reprojected in SRID 3857
wget -O master.zip https://github.com/igit036/sld/archive/master.zip -- pack of files (sld, sql, xml)
wget -O add_ladoga.zip https://github.com/igit036/files/raw/master/add_ladoga.zip -- polygon of Ladoga Lake (need for Leningradskaya oblast)
wget -O geoserver-2.11.0-vectortiles-plugin.zip http://sourceforge.net/projects/geoserver/files/GeoServer/2.11.0/extensions/geoserver-2.11.0-vectortiles-plugin.zip -- control version of geoserver

sudo apt-get install p7zip-ful  -- instal 7zip
7z e water-polygons-split-3857.zip -o./shp -r -y
7z e add_ladoga.zip -o./shp -r -y
7z e master.zip -o./sld -r -y

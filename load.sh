#!/bin/bash

DB=test

-- Setup the schema.
psql -d "$DB" -f ./sql/10_fdw_flybase.sql
psql -d "$DB" -f ./sql/12_fdw_schema.sql
psql -d "$DB" -f ./sql/20_mumine_schema.sql
psql -d "$DB" -f ./sql/22_mumine_funcitons.sql
psql -d "$DB" -f ./sql/24_mumine_tables.sql
psql -d "$DB" -f ./sql/80_view.sql

-- Quick and dirty, insert files
psql -d "$DB" -f- <<EOF
	INSERT INTO mumine.sheet (id,name) VALUES
		( 1, 'Fly_Ubqn-GFP_IP.csv' ),
		( 2, 'Fly_GFP_Repeat2.csv' ),
		( 3, 'Fly_IP_repeat3.csv' ),
		( 4, 'Fly_IP_repeat4.csv' ),
		( 5, 'AdultHead_MS_results.csv' );
EOF

-- Load data
cat \
 	<(sed -e's/^/1,/g' 1_Fly_Ubqn-GFP_IP.csv)    \
	<(sed -e's/^/2,/g' 2_Fly_GFP_Repeat2.csv)    \
	<(sed -e's/^/3,/g' 3_Fly_IP_repeat3.csv)     \
	<(sed -e's/^/4,/g' 4_Fly_IP_repeat4.csv)     \
	<(sed -e's/^/5,/g' 5_AdultHead_MS_results.csv) |
	psql -d "$DB" -c "\COPY mumine.data FROM STDIN WITH (FORMAT csv);"

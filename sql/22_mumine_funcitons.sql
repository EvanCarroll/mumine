CREATE OR REPLACE FUNCTION mumine.name_protein( name_compound text )
RETURNS text AS $$
	SELECT x[1]
	FROM regexp_matches(name_compound,'^([^(]+) \(')
		WITH ORDINALITY
		AS re(x,o)
	ORDER BY o
	LIMIT 1
$$ LANGUAGE sql
IMMUTABLE;


CREATE OR REPLACE FUNCTION mumine.name_orf_gene( name_compound text )
RETURNS text[] AS $$
	SELECT regexp_split_to_array(
		(
			SELECT x[1]
			FROM regexp_matches(name_compound,'^[^()]+(?:\(Fragment\))? \(([^)]+?)\) ')
				WITH ORDINALITY
				AS re(x,o)
			ORDER BY o
			LIMIT 1
		),
		'[,;]'
	);
$$ LANGUAGE sql
IMMUTABLE;
	COMMENT ON FUNCTION mumine.name_orf_gene(text)
		IS 'Species-specific "Ordered locus names"';


CREATE OR REPLACE FUNCTION mumine.name_human_ortholog( name_compound text )
RETURNS text[] AS $$
	SELECT regexp_split_to_array(
		(
			SELECT x[1]
			FROM regexp_matches(name_compound,' \[([^[]+)\] - \[')
				WITH ORDINALITY
				AS re(x,o)
			ORDER BY o
			LIMIT 1
		),
		'[,;]'
	);
$$ LANGUAGE sql
IMMUTABLE;


CREATE OR REPLACE FUNCTION mumine.name_uniprotkb( name_compound text )
RETURNS text AS $$
	SELECT x[1]
	FROM regexp_matches(name_compound,'\] - \[(.+?)\]$')
		WITH ORDINALITY
		AS re(x,o)
	ORDER BY o
	LIMIT 1;
$$ LANGUAGE sql
IMMUTABLE;

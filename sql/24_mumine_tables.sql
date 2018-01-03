CREATE TABLE mumine.sheet (
	id    int   PRIMARY KEY,
	name  text
);
CREATE TABLE mumine.data (
	sheet_id      int     REFERENCES mumine.sheet,
	NCBI_GI       text,
	name_compound  text,
	wt_property   double precision,
	wt_area       double precision,
	gfp_peptides  double precision,
	area          double precision
);


DROP VIEW IF EXISTS mumine.normalized_local;
CREATE VIEW mumine.normalized_local
AS
	SELECT
		sheet_id,
		ncbi_gi,
		CASE
			WHEN cardinality(mumine.name_orf_gene(name_compound))=1 AND (mumine.name_orf_gene(name_compound))[1] NOT LIKE 'EG:%'
				THEN (mumine.name_orf_gene(name_compound))[1]

			WHEN mumine.name_protein(name_compound) NOT LIKE 'EG:%'
				THEN mumine.name_protein(name_compound)

			ELSE (mumine.name_orf_gene(name_compound))[1]
		END normalized,
		mumine.name_orf_gene(name_compound)           AS ort_gene,
		mumine.name_protein(name_compound)            AS protein,
		mumine.name_human_ortholog( name_compound )   AS human_ortholog,
		mumine.mumine.name_uniprotkb( name_compound ) AS uniprotkb
		wt_property,
		wt_area,
		gfp_peptides,
		area
	FROM mumine.data ;

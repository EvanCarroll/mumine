CREATE extension postgres_fdw;

CREATE SERVER flybase
	FOREIGN DATA WRAPPER postgres_fdw
	OPTIONS (
		host 'chado.flybase.org',
		dbname 'flybase',
		use_remote_estimate 'true'
	);

-- It's just a public database
CREATE USER MAPPING FOR CURRENT_USER
	SERVER flybase
	OPTIONS (user 'flybase', password '' );

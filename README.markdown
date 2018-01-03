NAME
====

Chado FDW and data loaders.

DESCRIPTION
====

No idea what generates this data, but essentially I got a bunch of stuff like 

```
B5X552,SD13785p (Fragment) (CG11873-RA) [] - [B5X552_DROME],,,1,5.678E5
Q4V5Z4,IP11818p (CG11360) [MEX3A;MEX3B;MEX3C;MEX3D] - [Q4V5Z4_DROME],,,1,1.168E5
```

The fields are described in [the sql column names](./sql/24_mumine_tables.sql).
The compound name, second field in the above example gets parsed into the
constituent parts,

* name_uniprotkb
* name_human_ortholog
* name_orf_gene
* name_protein

Then a normalized name gets produced which is ideally the `orf_gene`, unless
that's wrong otherwise it is the `name_protein` unless that's also wrong
(search `EG:`) in which case we fall back and use the `orf_gene`.

We further link with Chado using PostgreSQL's
[`postgres_fdw`](https://www.postgresql.org/docs/current/static/postgres-fdw.html)
so we can run cross-db queries.

**EVERYTHING INSTALLS INTO `mumine` SCHEMA**

LICENSE
====

CC-BY-SA 4.0

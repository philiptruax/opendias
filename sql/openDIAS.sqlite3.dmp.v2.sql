-- 
-- Do not edit this file.
-- If you need to update the schema or default data, create a new file 
-- and update the DB version (in the 'version' table and DB_VERSION in src/main.c)
--
BEGIN TRANSACTION;

ALTER TABLE docs
ADD COLUMN pages NUMERIC;

CREATE TEMPORARY TABLE t1_backup(a,b);
INSERT INTO t1_backup SELECT version, for_app_version FROM version;
DROP TABLE version;
CREATE TABLE version (
	version INTEGER PRIMARY KEY,
	for_app_version TEXT); 
INSERT INTO version SELECT a,b FROM t1_backup;
DROP TABLE t1_backup;

UPDATE version
SET version = 2,
for_app_version = "0.2.2";

COMMIT;

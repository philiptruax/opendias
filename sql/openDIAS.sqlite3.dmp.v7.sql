-- 
-- Do not edit this file.
-- If you need to update the schema or default data, create a new file 
-- and update the DB version (in the 'version' table and DB_VERSION in src/main.c)
--
BEGIN TRANSACTION;

UPDATE version SET version = 7;

DELETE FROM config WHERE config_option = "scan_directory";
DELETE FROM config WHERE config_option = "show_all_available";
DELETE FROM config WHERE config_option = "log_directory";

DROP TABLE user_access;

CREATE TABLE user_access (
  username CHAR(36) NOT NULL,
  password CHAR(36) NOT NULL,
  realname CHAR(255) NOT NULL,
  last_access CHAR(255) NOT NULL,
  created CHAR(255) NOT NULL,
  role INTEGER NOT NULL
);

CREATE INDEX user_access_username_idx
ON user_access(username ASC);

-- password = md5( <created> <password> <username> )
-- Here the password is 'admin'
INSERT INTO user_access 
VALUES ('admin','6e6a83f742b28434aea09d7e8534647a','Admin User',datetime('now'),'automatically',1); 


ALTER TABLE docs
ADD COLUMN image_phash TEXT DEFAULT '0';

INSERT INTO config (config_option, config_value) VALUES ("backpopulate_phash", "yes");

COMMIT;


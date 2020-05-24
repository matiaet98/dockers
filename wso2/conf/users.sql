DROP DATABASE IF exists apim_db;
DROP DATABASE IF exists shared_db;
DROP USER if exists apim_db;
DROP USER if exists shared_db;

CREATE DATABASE apim_db;
CREATE USER apim_db WITH ENCRYPTED PASSWORD 'apim_db';
GRANT ALL PRIVILEGES ON DATABASE apim_db TO apim_db;

CREATE DATABASE shared_db;
CREATE USER shared_db WITH ENCRYPTED PASSWORD 'shared_db';
GRANT ALL PRIVILEGES ON DATABASE shared_db TO shared_db;


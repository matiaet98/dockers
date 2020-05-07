1. Crear usuario en oracle 12

Conectado con sys:

```sql
CREATE USER WSO2 IDENTIFIED BY WSO2 ACCOUNT UNLOCK;
GRANT CONNECT TO WSO2;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE TO WSO2;
GRANT UNLIMITED TABLESPACE TO WSO2;
GRANT DBA TO WSO2;
COMMIT;
```

Conectado con WSO2:

```sql

```

2. Copiar driver ojdbc al docker (podemos hacer un dockerfile despues mejor)

```bash
wget https://repo1.maven.org/maven2/com/oracle/ojdbc/ojdbc8/19.3.0.0/ojdbc8-19.3.0.0.jar
docker cp ojdbc8-19.3.0.0.jar <wso2 container>:/home/wso2carbon/wso2am-3.1.0/repository/components/lib/
```



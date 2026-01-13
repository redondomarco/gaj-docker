# gaj-server-docker

### Clonamos este repo y creamos el archivo .env
```
git clone https://github.com/redondomarco/gaj-server.git

cd gaj-server

touch .env
mkdir -p ./conf/homeroot/
```

### Requerida la fuente del server, en la version deseada

```
git clone https://gitlab.rosario.gob.ar/externos/gaj/gaj-server-main.git

```

### requerida la fuente del front, en la version deseada

```
git clone https://gitlab.rosario.gob.ar/externos/gaj/gaj-frontend.git

cd ..
```
### requeridas credenciales

en la carpeta keys/ se esperan los siguientes archivos

```
-rw-rw-r-- 1 marco marco   6365 ene  8 16:34 aplication.yml
-rw-rw-r-- 1 marco marco   1490 ene 12 17:01 environment.docker.ts
-rw-rw-r-- 1 marco marco   3014 nov 13 16:21 m2-settings-v2.xml
-rw-rw-r-- 1 marco marco 774930 ene  5 16:07 m_gaj.esquema.sql
-rw-rw-r-- 1 marco marco     25 nov 17 14:54 README.md
-rw-rw-r-- 1 marco marco   5562 dic  4 18:06 sqlhosts
```

## construimos las imagenes de los contenedores
```
make build-server

make build-front
```

## iniciamos server, db y front

make start



## Server

para entrar en el contenedor server
```
make consola-server
```

una vez dentro generamos el war

```
root@xxxxxxxxxx:/opt# compilar.sh
```
### Notas del Server

test server

http://info-178.pm.rosario.gov.ar:8080/tmf/mantenedores/agentes/public

## Front 

para entrar en el contenedor front
```
make consola-front
```

### Notas del Front
si hacemos algun cambio en environment.docker.ts debemos rebuildear el proyecto

## DB

para ejecutar comandos en la db

```
docker exec -it gaj-db psql -U root -d gaj
```

```
psql (12.20 (Debian 12.20-1.pgdg110+1))
Type "help" for help.

gaj=# SELECT * FROM pg_catalog.pg_tables;
```
### Notas de la db

para guardar un dump de la base:

docker exec -t gaj-db pg_dumpall --inserts -c -U root > dump_$(date +%Y-%m-%d_%H_%M_%S).sql

para restaurarlo

make stop

sudo rm data/pg/*

cat keys/dump_2025-12-09_15_14_17.sql | docker exec -i gaj-db psql -U root -d gaj
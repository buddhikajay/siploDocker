#!/usr/bin/env bash
# https://deninet.com/blog/1588/docker-scratch-part-5-custom-entrypoints-and-configuration
# set -m
# set -e
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-1234}

WHITEBOARD_DB_NAME=${WHITEBOARD_DB_NAME:-whiteboard}
WHITEBOARD_DB_USER=${WHITEBOARD_DB_USER:-whiteboard}
WHITEBOARD_DB_PASSWORD=${WHITEBOARD_DB_PASSWORD:-1234}


COTURN_DB_USER=${COTURN_DB_USER:-coturn}
COTURN_DB_NAME=${COTURN_DB_NAME:-coturn}
COTURN_DB_PASSWORD=${COTURN_DB_PASSWORD:-1234}

# mysqld_safe &

mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${WHITEBOARD_DB_NAME}"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON ${WHITEBOARD_DB_NAME}.* to '${WHITEBOARD_DB_USER}'@'%' IDENTIFIED BY '${WHITEBOARD_DB_PASSWORD}'"

mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${COTURN_DB_NAME}"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON ${COTURN_DB_NAME}.* to '${COTURN_DB_USER}'@'%' IDENTIFIED BY '${COTURN_DB_PASSWORD}'"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e \
"USE ${COTURN_DB_NAME};
CREATE TABLE turnusers_lt (
    realm varchar(127) default '',
    name varchar(512),
    hmackey char(128),
    PRIMARY KEY (realm,name)
);
CREATE TABLE turn_secret (
    realm varchar(127) default '',
        value varchar(128),
    primary key (realm,value)
);
CREATE TABLE allowed_peer_ip (
    realm varchar(127) default '',
    ip_range varchar(256),
    primary key (realm,ip_range)
);
CREATE TABLE denied_peer_ip (
    realm varchar(127) default '',
    ip_range varchar(256),
    primary key (realm,ip_range)
);
CREATE TABLE turn_origin_to_realm (
    origin varchar(127),
    realm varchar(127),
    primary key (origin,realm)
);
CREATE TABLE turn_realm_option (
    realm varchar(127) default '',
    opt varchar(32),
    value varchar(128),
    primary key (realm,opt)
);
CREATE TABLE oauth_key (
    kid varchar(128), 
    ikm_key varchar(256),
    timestamp bigint default 0,
    lifetime integer default 0,
    as_rs_alg varchar(64) default '',
    primary key (kid)
);
CREATE TABLE admin_user (
    name varchar(32),
    realm varchar(127),
    password varchar(127),
    primary key (name)
);
"

mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES"



# fg

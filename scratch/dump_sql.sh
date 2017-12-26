#!/usr/bin/env bash
set -ex
echo "DROP DATABASE IF EXISTS gazelle_jumper; CREATE DATABASE gazelle_jumper;" | mysql -uroot
sqlite3 $1 .dump | sed \
-e '/PRAGMA.*;/ d' \
-e '/BEGIN TRANSACTION.*/ d' \
-e '/COMMIT;/ d' \
-e '/.*sqlite_sequence.*;/d' \
-e 's/"/`/g' \
-e 's/CREATE TABLE \(`\w\+`\)/DROP TABLE IF EXISTS \1;\nCREATE TABLE \1/' \
-e 's/\(CREATE TABLE.*\)\(PRIMARY KEY\) \(AUTOINCREMENT\)\(.*\)\();\)/\1AUTO_INCREMENT\4, PRIMARY KEY(id)\5/' \
-e 's/DEFAULT (\([^)]*\))/DEFAULT \1/' \
-e 's/DEFAULT (NULL) //g' \
-e 's/DEFAULT NULL //g' \
-e 's/integer/BIGINT/g' \
-e 's/timestamp,/TIMESTAMP DEFAULT CURRENT_TIMESTAMP,/g' \
-e 's/FOREIGN KEY [^,]*,//g' \
-e "s/'t'/1/g" \
-e "s/'f'/0/g" \
| mysql -uroot gazelle_jumper

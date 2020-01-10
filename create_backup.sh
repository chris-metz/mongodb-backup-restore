#!/bin/bash

# WARNING: NO CHECK FOR $1 FILE EXISTENCE / VALIDITY YET!

source $1

TEMPDIR=/tmp/mongodb-backups
mkdir $TEMPDIR
DATUM=`date +"%Y-%m-%d-%H-%M-%S"`

for db in $DBS
do
  echo $uri
  docker run --rm -v $TEMPDIR:/tmp/mb \
  mongo:4.2.1 bash -c 'mongodump -v --ssl --sslAllowInvalidCertificates --host '$HOST' --authenticationDatabase '$AUTHDB' --db '$db' --username '$USER' --password '$PASSWORD' --out=/tmp/mb'
  sudo chown -R $USER:$USER $TEMPDIR
done

cd $TEMPDIR
borg create --stats --progress --compression lz4 ${BORG_REPO}::${DATUM} .
borg prune -v --list $BORG_REPO --keep-hourly=12 --keep-daily=7 --keep-weekly=4 --keep-monthly=24

cd /
rm -rf $TEMPDIR

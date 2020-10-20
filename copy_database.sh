#!/bin/bash

set -e

# WARNING: NO CHECK FOR $1 FILE EXISTENCE / VALIDITY YET!
source $1

TEMPDIR=/tmp/mongodb-copy
mkdir $TEMPDIR
cd $TEMPDIR

docker run --rm -v $TEMPDIR:/tmp/mb mongo:4.2.10 bash -c 'mongodump -v --ssl --sslAllowInvalidCertificates --host '$SRC_HOST' --authenticationDatabase '$SRC_AUTHDB' --db '$SRC_DB' --username '$SRC_USER' --password '$SRC_PASSWORD' --out=/tmp/mb'
sudo chown -R $USER:$USER $TEMPDIR

docker run --rm -it -v ${TEMPDIR}/${SRC_DB}:/restore/ mongo:4.2.10 bash -c 'mongorestore -v --ssl  --sslAllowInvalidCertificates --host '$DEST_HOST' --authenticationDatabase '$DEST_AUTHDB' --db '$DEST_DB' --username '$DEST_USER' --password '$DEST_PASSWORD' --drop /restore/'

cd
rm -rf $TEMPDIR

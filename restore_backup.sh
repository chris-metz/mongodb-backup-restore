#!/bin/bash

# WARNING: TARGET DATABASE WILL BE DROPPED / OVERRIDDEN BY BACKUP!
# WARNING: NO CHECK FOR $1 FILE EXISTENCE / VALIDITY YET!

source $1

# choose one, depending on configuration (--uri or --host)
# TODO refactor to use one conditionally based on set env  file variables ($1)

docker run --rm -it -v $BACKUP_LOCATION:/restore/ \
 mongo:4.4 bash -c 'mongorestore -v --ssl  --sslAllowInvalidCertificates --host '$HOST' --authenticationDatabase '$AUTHDB' --db '$TARGET_DATABASE' --username '$USER' --password '$PASSWORD' --drop /restore/'

docker run --rm -it -v $BACKUP_LOCATION:/restore/ \
 mongo:4.4 bash -c 'mongorestore -v --ssl  --sslAllowInvalidCertificates --uri '$URI' --authenticationDatabase '$AUTHDB' --db '$TARGET_DATABASE' --username '$USER' --password '$PASSWORD' --drop /restore/'

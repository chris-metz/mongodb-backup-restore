#!/bin/bash

# WARNING: TARGET DATABASE WILL BE DROPPED / OVERRIDDEN BY BACKUP!
# WARNING: NO CHECK FOR $1 FILE EXISTENCE / VALIDITY YET!

source $1

docker run --rm -it -v $BACKUP_LOCATION:/restore/ \
 mongo:4.2.1 bash -c 'mongorestore -v --ssl  --sslAllowInvalidCertificates --host '$HOST' --authenticationDatabase '$AUTHDB' --db '$TARGET_DATABASE' --username '$USER' --password '$PASSWORD' --drop /restore/'
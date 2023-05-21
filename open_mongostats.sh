#!/bin/bash

source $1

docker run --rm -it \
 mongo:6.0.3 bash -c 'mongostat  --ssl  --authenticationDatabase '$AUTHDB' --username '$USER' --password '$PASSWORD' '$URI''

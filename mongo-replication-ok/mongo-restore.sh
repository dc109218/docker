#!/bin/bash

DB_BACKUP_PATH="/data"
RESTOREFILE_R="xyz-prod-150423-171419.gz"
RESTOREFILE_D="xyz-prod-150423-171419.gz"

ROLEURI="mongodb://user:password@10.10.10.10:6390/dbname?directConnection=true"
# DEVURI="mongodb://devdcsurani:9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath@10.10.10.10:6390/devappapin?ssl=false&retryWrites=true&w=majority&readPreference=primary&replicaSet=rep-role"
DEVURI="mongodb://user:password@10.10.10.10:6390/dbname?directConnection=true"

DBNMROLEIT='xyz1'
DBNMDEVOPPS='xyz2'

######################################################################
function xyz1 {
  if [ ${DBNMROLEIT} = "ALL" ]; then
    echo "You have choose to restore ALL databases"
    mongorestore --uri ${ROLEURI} --db ${DBNM} --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_R}
    # mongorestore --host=$HOST --port=$PORT -u=$USER -p=$PASS --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_R}
  else
      echo "Running restore for selected $DBNMROLEIT databases"
    for DB_NAME in $DBNMROLEIT; do
      mongorestore --uri ${ROLEURI} --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_R}
    #   mongorestore --host=$HOST --port=$PORT -u=$USER -p=$PASS --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_R}
x-mongo-replication-ok/READme.md    done
  fi
}
echo "Done=======DevOpsDB, $DBNMROLEIT"

function xyz2 {
  if [ $DBNMDEVOPPS = "ALL" ]; then
    echo "You have choose to restore ALL databases"
    mongorestore --uri ${DEVURI} --db ${DBNM} --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_D}
    # mongorestore --host=$HOST --port=$PORT -u=$USER -p=$PASS --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_D}
  else
      echo "Running restore for selected $DBNMDEVOPPS databases"
    for DB_NAME in $DBNMDEVOPPS; do
      mongorestore --uri ${DEVURI} --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_D}
    #   mongorestore --host=$HOST --port=$PORT -u=$USER -p=$PASS --drop --gzip --archive=${DB_BACKUP_PATH}/${RESTOREFILE_D}
    done
  fi
}
echo "Done=======DevOpsDB, $DBNMDEVOPPS"

xyz1;
xyz2;

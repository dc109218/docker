#!/bin/bash

DB_BACKUP_PATH="/data"

ROLEURI="mongodb://user:password@10.0.1.238:27116,10.0.2.93:27117,10.0.1.209:27118/dbname?ssl=false&retryWrites=true&w=majority&readPreference=primary&replicaSet=reprit"
DEVURI="mongodb://user:password@10.0.1.238:27116,10.0.2.93:27117,10.0.1.209:27118/dbname?ssl=false&retryWrites=true&w=majority&readPreference=primary&replicaSet=reprit"

# DATABASE_NAMES='ALL'
DBNMROLEIT='xyz'
DBNMDEVOPPS='xyz'

RoleitFILE=xyz-prod-`date +"%d%m%y-%H%M%S"`.gz
DevopsFILE=xyz-prod-`date +"%d%m%y-%H%M%S"`.gz

function xyz1 {
    if [ ${DBNMROLEIT} = "ALL" ]; then
        echo "You have choose to backup all databases"
        # mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/
        mongodump --uri ${ROLEURI} --gzip --archive ${DB_BACKUP_PATH}/${RoleitFILE}
    else
            echo "Running backup for selected databases"
        for DB_NAME in ${DBNMROLEIT}; do
            # mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} --db ${DB_NAME} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/
            mongodump --uri ${ROLEURI} --db ${DB_NAME} --gzip --archive=${DB_BACKUP_PATH}/${RoleitFILE}
        done
    fi
}
echo "Done=======DevOpsDB, $DBNMROLEIT"

function xyz2 {
    if [ ${DBNMDEVOPPS} = "ALL" ]; then
        echo "You have choose to backup all databases"
        # mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/
        mongodump --uri ${DEVURI} --gzip --archive ${DB_BACKUP_PATH}/${DevopsFILE}
    else
            echo "Running backup for selected databases"
        for DB_NAME in ${DBNMDEVOPPS}; do
            # mongodump --host ${MONGO_HOST} --port ${MONGO_PORT} --db ${DB_NAME} ${AUTH_PARAM} --out ${DB_BACKUP_PATH}/${TODAY}/
            mongodump --uri ${DEVURI} --db ${DB_NAME} --gzip --archive=${DB_BACKUP_PATH}/${DevopsFILE}
        done
    fi
}
echo "Done=======DevOpsDB, $DBNMDEVOPPS"

xyz1;
xyz2;

# /home/mongo-backup.sh
# 30 2 * * * bash /home/mongo-backup.sh >> /home/crontab.log 2>&1
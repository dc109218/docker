#!/bin/bash

mongosh <<EOF
    use admin;
    db.createUser({user: "helloadmin",pwd: "importantmyfamilyandfriends07042023",roles: [ { role: "userAdminAnyDatabase", db: "admin" },  { "role" : "clusterAdmin", "db" : "admin" } ]});
    use liveroleitapin;
    db.createUser({user: "dcsurani",pwd: "Ath9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0",roles: [ { role: "readWrite", db: "liveroleitapin" } ]});
    use devappapin;
    db.createUser({user: "devdcsurani",pwd: "9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath",roles: [ { role: "readWrite", db: "devappapin" } ]});
    exit;
EOF
#!/bin/bash

mongosh <<EOF
var config = {"_id": "rs-config-server","configsvr": true,"version": 1,"members": [{"_id": 0,"host": "10.122.0.2:27119","priority": 1},{"_id": 1,"host": "10.122.0.3:27120","priority": 0.5}]};
rs.initiate(config, { force: true });
EOF
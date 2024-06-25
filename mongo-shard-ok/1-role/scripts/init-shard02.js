#!/bin/bash

mongosh <<EOF
    var config = {"_id": "rs-shard-02","version": 1,"members": [{"_id": 0,"host": "10.122.0.2:27125","priority": 1},{"_id": 1,"host": "10.122.0.3:27126","priority": 0.5}]};
    rs.initiate(config, { force: true });
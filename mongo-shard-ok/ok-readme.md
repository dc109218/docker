# MongoDB (6.0.2) Sharded Cluster - Keyfile Authetication

## Primary - Secondary - Secondary - w/ 👉 Keyfile Authetication 👈

* Config Server (3 member replica set): `configsvr01`,`configsvr02`,`configsvr03`
* 3 Shards (each a 3 member `PSS` replica set):
   * `shard01-a`, `shard01-b`, `shard01-c`
   * `shard02-a`, `shard02-b`, `shard02-c`
   * `shard03-a`, `shard03-b`, `shard03-c`

* 2 Routers (mongos):
   * `router01`, `router02`, `router03`

## ✨ Steps [🔝](#-table-of-contents)

### 🔨 Preparing

## Linux
```sh
openssl rand -base64 756 > mongodb-keyfile
chmod 400 mongodb-keyfile
```
## Window
```sh
cd C:\Program Files\OpenSSL-Win64\bin
openssl rand -base64 700 > mongodb-keyfile
```

### 👉 Step 1: Start all of the containers [🔝](#-table-of-contents)

```bash
docker-compose up -d
```

### 👉 Step 2: Initialize the replica sets (config servers and shards) [🔝](#-table-of-contents)
Run these command one by one:

```bash
docker-compose exec configsvr01 bash "/scripts/init-configserver.js"
docker-compose exec shard01-a bash "/scripts/init-shard01.js"
docker-compose exec shard02-a bash "/scripts/init-shard02.js"
# docker-compose exec shard03-a bash "/scripts/init-shard03.js"

```

### 👉 Step 3: Initializing the router [🔝](#-table-of-contents)

> Note: Wait a bit 5-10 seconds for the config server and shards to elect their primaries before initializing the router

```bash
docker-compose exec router01 sh -c "mongosh < /scripts/init-router.js"
```

### 👉 Step 4: Setup authentication

Default account is `your_admin` / `your_password`

```bash
docker-compose exec configsvr01 "mongosh"
        use admin;
        db.createUser({user: "helloadmin",pwd: "importantmyfamilyandfriends07042023",roles: [ { role: "userAdminAnyDatabase", db: "admin" },  { "role" : "clusterAdmin", "db" : "admin" } ]});
        exit;
docker-compose exec configsvr01 "mongosh"
        use admin;
        db.auth("helloadmin", "importantmyfamilyandfriends07042023");
        use liveroleitapin;
        db.createUser({user: "dcsurani",pwd: "faeg6keisoobe0",roles: [ { role: "readWrite", db: "liveroleitapin" } ]});
        use devappapin;
        db.createUser({user: "devdcsurani",pwd: "e1faeg6keisoobe0Ath",roles: [ { role: "readWrite", db: "devappapin" } ]});
        exit;

# docker-compose exec shard01-a bash "/scripts/auth.js"
docker-compose exec shard01-a "mongosh"
        use admin;
        db.createUser({user: "helloadmin",pwd: "importantmyfamilyandfriends07042023",roles: [ { role: "userAdminAnyDatabase", db: "admin" },  { "role" : "clusterAdmin", "db" : "admin" } ]});
        exit;
docker-compose exec shard01-a "mongosh"
        use admin;
        db.auth("helloadmin", "importantmyfamilyandfriends07042023");
        use liveroleitapin;
        db.createUser({user: "dcsurani",pwd: "faeg6keisoobe0",roles: [ { role: "readWrite", db: "liveroleitapin" } ]});
        use devappapin;
        db.createUser({user: "devdcsurani",pwd: "e1faeg6keisoobe0Ath",roles: [ { role: "readWrite", db: "devappapin" } ]});
        exit;
        

docker-compose exec shard02-a "mongosh"
        use admin;
        db.createUser({user: "helloadmin",pwd: "importantmyfamilyandfriends07042023",roles: [ { role: "userAdminAnyDatabase", db: "admin" },  { "role" : "clusterAdmin", "db" : "admin" } ]});
        exit;
docker-compose exec shard02-a "mongosh"
        use admin;
        db.auth("helloadmin", "importantmyfamilyandfriends07042023");
        use liveroleitapin;
        db.createUser({user: "dcsurani",pwd: "faeg6keisoobe0",roles: [ { role: "readWrite", db: "liveroleitapin" } ]});
        use devappapin;
        db.createUser({user: "devdcsurani",pwd: "e1faeg6keisoobe0Ath",roles: [ { role: "readWrite", db: "devappapin" } ]});
        exit;

# docker-compose exec shard03-a bash "/scripts/auth.js"
```

### 👉 Step 5: Enable sharding and setup sharding-key [🔝](#-table-of-contents)

Firstly, you need to access to router, it will ask your password:

```bash
docker-compose exec router01 bash -c "mongosh -u helloadmin --authenticationDatabase admin"
# docker-compose exec router01 "mongosh"
db.auth("helloadmin", "importantmyfamilyandfriends07042023");

docker-compose exec router01 bash -c "mongosh -u dcsurani --authenticationDatabase liveroleitapin"
db.auth("dcsurani", "faeg6keisoobe0");
```

Enter your password, in this case password is `your_password`, then run these commands to create database and enable sharding.
Here we will create database `MyDatabase` and collection `MyCollection`
Enable sharding for database `MyDatabase`

```sh
sh.enableSharding("liveroleitapin")
sh.enableSharding("devappapin")
```

Setup shardingKey for collection `MyCollection`**

```md
db.adminCommand( { shardCollection: "liveroleitapin.MyCollection1", key: { oemNumber: "hashed", zipCode: 1, supplierId: 1 }})
db.adminCommand( { shardCollection: "liveroleitapin.MyCollection5", key: { oemNumber: "hashed", zipCode: 1, supplierId: 1 }})
db.adminCommand( { shardCollection: "devappapin.MyCollection4", key: { oemNumber: "hashed", zipCode: 1, supplierId: 1}})
```

---

### ✔️ Done !!!

#### But before you start inserting data you should verify them first

Btw, here is mongodb connection string if you want to try to connect mongodb cluster with MongoDB Compass from your host computer

```ini
mongodb://helloadmin:importantmyfamilyandfriends07042023@10.0.101.155:27116,10.0.102.150:27117,10.0.102.211:27118/?authMechanism=DEFAULT

10.0.1.238:27116,10.0.2.93:27117,10.0.1.209:27118

docker run --rm mongo:5.0.15-focal which mongo mongosh mongod

docker run --rm -it dcsurani/mongo:5.0.15-focal mongosh "mongodb://helloadmin:importantmyfamilyandfriends07042023@10.0.1.238:27116,10.0.2.93:27117,10.0.1.209:27118/"


```

## 📋 Verify [🔝](#-table-of-contents)

### ✅ Verify the status of the sharded cluster [🔝](#-table-of-contents)

```sh
docker exec -it router-01 bash -c "echo 'sh.status()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"

```

or

```bash
docker-compose exec router01 mongosh --port 27017 -u "your_admin" --authenticationDatabase admin
sh.status()

```

*Sample Result:*

```json
  sharding version: {
        "_id" : 1,
        "minCompatibleVersion" : 5,
        "currentVersion" : 6,
        "clusterId" : ObjectId("5d38fb010eac1e03397c355a")
  }
  shards:
        {  "_id" : "rs-shard-01",  "host" : "rs-shard-01/shard01-a:27017,shard01-b:27017,shard01-c:27017",  "state" : 1 }
        {  "_id" : "rs-shard-02",  "host" : "rs-shard-02/shard02-a:27017,shard02-b:27017,shard02-c:27017",  "state" : 1 }
        {  "_id" : "rs-shard-03",  "host" : "rs-shard-03/shard03-a:27017,shard03-b:27017,shard03-c:27017",  "state" : 1 }
  active mongoses:
        "4.0.10" : 2
  autosplit:
        Currently enabled: yes
  balancer:
        Currently enabled:  yes
        Currently running:  no
        Failed balancer rounds in last 5 attempts:  0
        Migration Results for the last 24 hours:
                No recent migrations
  databases:
        {  "_id" : "config",  "primary" : "config",  "partitioned" : true }

```

### ✅ Verify status of replica set for each shard [🔝](#-table-of-contents)

> You should see 1 PRIMARY, 2 SECONDARY

```bash
docker exec -it shard-01-node-a bash -c "echo 'rs.status()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"
docker exec -it shard-02-node-a bash -c "echo 'rs.status()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"
docker exec -it shard-03-node-a bash -c "echo 'rs.status()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"

```

*Sample Result:*

```ps1
MongoDB shell version v4.0.11
connecting to: mongodb://127.0.0.1:27017/?gssapiServiceName=mongodb
Implicit session: session { "id" : UUID("dcfe5d8f-75ef-45f7-9595-9d72dc8a81fc") }
MongoDB server version: 4.0.11
{
        "set" : "rs-shard-01",
        "date" : ISODate("2019-08-01T06:53:59.175Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncingTo" : "",
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1564642438, 1),
                        "t" : NumberLong(1)
                },
                "readConcernMajorityOpTime" : {
                        "ts" : Timestamp(1564642438, 1),
                        "t" : NumberLong(1)
                },
                "appliedOpTime" : {
                        "ts" : Timestamp(1564642438, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1564642438, 1),
                        "t" : NumberLong(1)
                }
        },
        "lastStableCheckpointTimestamp" : Timestamp(1564642428, 1),
        "members" : [
                {
                        "_id" : 0,
                        "name" : "shard01-a:27017",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 390,
                        "optime" : {
                                "ts" : Timestamp(1564642438, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2019-08-01T06:53:58Z"),
                        "syncingTo" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1564642306, 1),
                        "electionDate" : ISODate("2019-08-01T06:51:46Z"),
                        "configVersion" : 2,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 1,
                        "name" : "shard01-b:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 142,
                        "optime" : {
                                "ts" : Timestamp(1564642428, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1564642428, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2019-08-01T06:53:48Z"),
                        "optimeDurableDate" : ISODate("2019-08-01T06:53:48Z"),
                        "lastHeartbeat" : ISODate("2019-08-01T06:53:57.953Z"),
                        "lastHeartbeatRecv" : ISODate("2019-08-01T06:53:57.967Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "shard01-a:27017",
                        "syncSourceHost" : "shard01-a:27017",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 2
                },
                {
                        "_id" : 2,
                        "name" : "shard01-c:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 142,
                        "optime" : {
                                "ts" : Timestamp(1564642428, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1564642428, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2019-08-01T06:53:48Z"),
                        "optimeDurableDate" : ISODate("2019-08-01T06:53:48Z"),
                        "lastHeartbeat" : ISODate("2019-08-01T06:53:57.952Z"),
                        "lastHeartbeatRecv" : ISODate("2019-08-01T06:53:57.968Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "shard01-a:27017",
                        "syncSourceHost" : "shard01-a:27017",
                        "syncSourceId" : 0,
                        "infoMessage" : "",
                        "configVersion" : 2
                }
        ],
        "ok" : 1,
        "operationTime" : Timestamp(1564642438, 1),
        "$gleStats" : {
                "lastOpTime" : Timestamp(0, 0),
                "electionId" : ObjectId("7fffffff0000000000000001")
        },
        "lastCommittedOpTime" : Timestamp(1564642438, 1),
        "$configServerState" : {
                "opTime" : {
                        "ts" : Timestamp(1564642426, 2),
                        "t" : NumberLong(1)
                }
        },
        "$clusterTime" : {
                "clusterTime" : Timestamp(1564642438, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}
bye
```

### ✅ Check database status [🔝](#-table-of-contents)

```bash
docker-compose exec router01 mongosh --port 27017 -u "your_admin" --authenticationDatabase admin
use MyDatabase
db.stats()
db.MyCollection.getShardDistribution()

```

*Sample Result:*

```scala
{
        "raw" : {
                "rs-shard-01/shard01-a:27017,shard01-b:27017,shard01-c:27017" : {
                        "db" : "MyDatabase",
                        "collections" : 1,
                        "views" : 0,
                        "objects" : 0,
                        "avgObjSize" : 0,
                        "dataSize" : 0,
                        "storageSize" : 4096,
                        "numExtents" : 0,
                        "indexes" : 2,
                        "indexSize" : 8192,
                        "fsUsedSize" : 12439990272,
                        "fsTotalSize" : 62725787648,
                        "ok" : 1
                },
                "rs-shard-03/shard03-a:27017,shard03-b:27017,shard03-c:27017" : {
                        "db" : "MyDatabase",
                        "collections" : 1,
                        "views" : 0,
                        "objects" : 0,
                        "avgObjSize" : 0,
                        "dataSize" : 0,
                        "storageSize" : 4096,
                        "numExtents" : 0,
                        "indexes" : 2,
                        "indexSize" : 8192,
                        "fsUsedSize" : 12439994368,
                        "fsTotalSize" : 62725787648,
                        "ok" : 1
                },
                "rs-shard-02/shard02-a:27017,shard02-b:27017,shard02-c:27017" : {
                        "db" : "MyDatabase",
                        "collections" : 1,
                        "views" : 0,
                        "objects" : 0,
                        "avgObjSize" : 0,
                        "dataSize" : 0,
                        "storageSize" : 4096,
                        "numExtents" : 0,
                        "indexes" : 2,
                        "indexSize" : 8192,
                        "fsUsedSize" : 12439994368,
                        "fsTotalSize" : 62725787648,
                        "ok" : 1
                }
        },
        "objects" : 0,
        "avgObjSize" : 0,
        "dataSize" : 0,
        "storageSize" : 12288,
        "numExtents" : 0,
        "indexes" : 6,
        "indexSize" : 24576,
        "fileSize" : 0,
        "extentFreeList" : {
                "num" : 0,
                "totalSize" : 0
        },
        "ok" : 1,
        "operationTime" : Timestamp(1564004884, 36),
        "$clusterTime" : {
                "clusterTime" : Timestamp(1564004888, 1),
                "signature" : {
                        "hash" : BinData(0,"AAAAAAAAAAAAAAAAAAAAAAAAAAA="),
                        "keyId" : NumberLong(0)
                }
        }
}

```

## 🔎 More commands [🔝](#-table-of-contents)

```bash
docker exec -it mongo-config-01 bash -c "echo 'rs.status()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"

docker exec -it shard-01-node-a bash -c "echo 'rs.help()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"
docker exec -it shard-01-node-a bash -c "echo 'rs.status()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin" 
docker exec -it shard-01-node-a bash -c "echo 'rs.printReplicationInfo()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin" 
docker exec -it shard-01-node-a bash -c "echo 'rs.printSlaveReplicationInfo()' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"

```

For step 4, you also can exec command directly in container, run bellow command line by line (for example configserver) :

```ts
docker-compose exec configsvr01 mongosh --port 27017
rs.initiate({_id: "rs-config-server", configsvr: true, version: 1, members: [ { _id: 0, host : 'configsvr01:27017' }, { _id: 1, host : 'configsvr02:27017' }, { _id: 2, host : 'configsvr03:27017' } ] });
use admin;
db.createUser({user: "your_admin", pwd: "your_password", roles:[{role: "root", db: "admin"}]});
exit;

```

Try to insert some documents, make sure that you switched to database that have just created by using:

```sh
use MyDatabase

```

then run:

```yaml
db.MyCollection.insertMany([
{ oemNumber: "AAAAAAA", zipCode: 11111, supplierId: "02e1e275-6aa4-43ff-bfb3-39c48ac918b0" },
{ oemNumber: "BBBBBBB", zipCode: 22222, supplierId: "5f55b8b3-43b2-4e02-a1b6-49a12eefc845" },
{ oemNumber: "CCCCCCC", zipCode: 33333, supplierId: "916e2fa8-74a8-40fa-a034-8497278031c3" },
{ oemNumber: "DDDDDDD", zipCode: 44444, supplierId: "70ffe46d-91cd-4552-812c-6c3395d52fcd" },
{ oemNumber: "EEEEEEE", zipCode: 11111, supplierId: "695d786c-3254-477d-a9af-9b628cec51e5" },
{ oemNumber: "AAAAAAA", zipCode: 11111, supplierId: "a589e2e1-6206-43a4-a948-617f3e26524d" }
]);

```

### Check electing status

```sh
docker exec -it mongo-config-01 bash -c "echo 'rs.status().members.forEach(function (m) { print(m.stateStr.split(\`":\`").shift()) })' | mongosh --port 27017"

docker exec -it shard-01-node-a bash -c "echo 'rs.status().members.forEach(function (m) { print(m.stateStr.split(\`":\`").shift()) })' | mongosh --port 27017"
docker exec -it shard-02-node-a bash -c "echo 'rs.status().members.forEach(function (m) { print(m.stateStr.split(\`":\`").shift()) })' | mongosh --port 27017"
docker exec -it shard-03-node-a bash -c "echo 'rs.status().members.forEach(function (m) { print(m.stateStr.split(\`":\`").shift()) })' | mongosh --port 27017"

```

If you configured authentication then use this syntax:

```sh
docker exec -it mongo-config-01 bash -c "echo 'rs.status().members.forEach(function (m) { print(m.stateStr.split(\`":\`").shift()) })' | mongosh --port 27017 -u 'your_admin' -p 'your_password' --authenticationDatabase admin"

```

---

### ✦ Normal Startup [🔝](#-table-of-contents)

The cluster only has to be initialized on the first run.

Subsequent startup can be achieved simply with `docker-compose up` or `docker-compose up -d`

### ✦ Resetting the Cluster [🔝](#-table-of-contents)

To remove all data and re-initialize the cluster, make sure the containers are stopped and then:

```bash
docker-compose rm

```

### ✦ Clean up docker-compose [🔝](#-table-of-contents)

```bash
docker-compose down -v --rmi all --remove-orphans

```

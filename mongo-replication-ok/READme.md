
docker-compose -f 1-docker-compose.yml down
docker-compose -f 2-docker-compose.yml down

docker-compose exec mprimary bash -c "mongosh -u helloadmin -p importantmyfamilyandfriends07042023"
cd /rit/smongo/2role/;docker-compose exec mslave mongosh -u "helloadmin" -p "importantmyfamilyandfriends07042023"

rs.initiate({"_id" : "reprit","members" : [{"_id" : 0,"host" : "10.122.0.4:27018"},{"_id" : 1,"host" : "10.122.0.4:27019",arbiterOnly: true},{"_id" : 2,"host" : "10.122.0.3:27020"},{"_id" : 3,"host" : "10.122.0.3:27021",arbiterOnly: true}]});

exit

# Set the priority of the master over the other nodes
conf = rs.config();
conf.members[0].priority = 2;
rs.reconfig(conf);

# Create a cluster admin
<!-- use admin; -->
<!-- db.createUser({user: "cluster_admin",pwd: "password",roles: [ { role: "userAdminAnyDatabase", db: "admin" },  { "role" : "clusterAdmin", "db" : "admin" } ]}); -->
db.auth("cluster_admin", "password");

use liveroleitapin;
db.createUser({user: "dcsurani",pwd: "Ath9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0",roles: [ { role: "readWrite", db: "liveroleitapin" } ]});

use devappapin;
db.createUser({user: "devdcsurani",pwd: "9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath",roles: [ { role: "readWrite", db: "devappapin" } ]});
exit;

db.auth("devdcsurani", "9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath");
<!-- db.dropDatabase() -->

# Create a collection on a database
use devappapin;
db.createCollection('my_collection');

# Verify credentials for primary
docker-compose exec mongo-primary mongosh -u "devdcsurani" -p "9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath" --authenticationDatabase "devappapin"

# Verify credentials for slave1
docker-compose exec mongo-slave1 mongosh -u "devdcsurani" -p "9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath" --authenticationDatabase "devappapin"

# test failover
docker stop role4-mongo-primary-1
docker-compose exec mongo-slave1 mongosh -u "helloadmin" -p "importantmyfamilyandfriends07042023"
rs.status();

# test write
docker-compose exec mongo-slave1 mongosh -u "devdcsurani" -p "9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath" --authenticationDatabase "devappapin"
use devappapin;
db.createCollection('my_collection3');
show collections

docker-compose exec tut12-mongo-primary mongosh -u "root" -p "password"
docker-compose exec tut12-mongo-worker-1 mongosh -u "root" -p "password"
docker-compose exec tut12-mongo-worker-2 mongosh -u "root" -p "password"
docker-compose exec tut12-mongo-worker-3 mongosh -u "root" -p "password"

===

mongodb://helloadmin:importantmyfamilyandfriends07042023@10.10.10.10:6390/admin?directConnection=true&tls=false

docker run --rm -it dcsurani/mongo:5.0.15-focal mongosh "mongodb://helloadmin:importantmyfamilyandfriends07042023@10.10.10.10:6390/admin?directConnection=true&tls=false"

docker compose down;rm -rf db/

?ssl=false&retryWrites=true&w=majority&readPreference=primary&replicaSet=rep-role

mongodb://devdcsurani:9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath@10.10.10.10:6390/devappapin?ssl=false&retryWrites=true&w=majority&readPreference=primary&replicaSet=rep-role

mongodb://devdcsurani:9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath@10.10.10.10:6390/devappapin?retryWrites=true&w=majority&readPreference=primary&replicaSet=rep-role&authSource=devappapin

===

docker exec -it mongo-primary mongosh -u "helloadmin" -p "importantmyfamilyandfriends07042023"
rs.status();

# remove replication members
cfg = rs.conf()
rs.remove("10.0.2.93:27019");
cfg.members.splice(2,1);
rs.reconfig(cfg)
rs.status();

# add replication members
cfg = rs.conf()
<!-- rs.add("10.0.102.211:27020") -->
rs.add( { host: "10.0.102.211:27020" } )
rs.status()


===
mongorestore --uri "mongodb://devdcsurani:9aeGaePhae4shaengeoLaeQu3eichee9weprodRoleitMuS1maifohDe1faeg6keisoobe0Ath@10.122.0.4:27018,10.122.0.3:27020/devappapin?replicaSet=reprit" --db "devappapin" --drop --gzip --archive="devappapin-prod-050623-140515.gz"

mongorestore -v --nsInclude=vehicles.vehicleinformation --uri "mongodb://helloadmin:importantmyfamilyandfriends07042023@10.122.0.4:27018,10.122.0.3:27020/devappapin?replicaSet=reprit&authSource=admin" "devappapin" --drop --gzip --archive="devappapin-prod-050623-140515.gz"

mongorestore -v --nsInclude=vehicles.vehicleinformation --uri "mongodb://helloadmin:importantmyfamilyandfriends07042023@10.122.0.4:27018,10.122.0.3:27020/devappapin?replicaSet=reprit" --authenticationDatabase admin --db "devappapin" --drop --gzip --archive="devappapin-prod-050623-140515.gz"

===

mongorestore -v --nsInclude=vehicles.vehicleinformation --uri "mongodb://helloadmin:importantmyfamilyandfriends07042023@10.122.0.4:27018,10.122.0.3:27020/liveroleitapin?ssl=false&retryWrites=true&w=majority&readPreference=primary&replicaSet=reprit" --authenticationDatabase admin --db "liveroleitapin" --drop --gzip --archive="liveroleitapin-prod-050623-140515.gz"

===

MONGO_USER="mongodb://helloadmin"
MONGO_PASSWORD="importantmyfamilyandfriends07042023"
MONGO_URL="@10.122.0.4:27018,10.122.0.3:27020/liveroleitapin?ssl=false&retryWrites=true&w=majority&readPreference=primary&replicaSet=reprit&authSource=admin"

cfg = rs.conf()
rs.reconfig(cfg, {force : true})


MONGO_USER="mongodb://helloadmin"
MONGO_PASSWORD="importantmyfamilyandfriends07042023"
MONGO_URL="@10.122.0.4:27018,10.122.0.3:27020/liveroleitapin?replicaSet=reprit&authSource=admin"


===



scp -i ~/.ssh/role-prod-imac "/Volumes/extraDrive/dcs_Drive/server/0-role-server-production/4-mongo-replication-ok/backup/liveroleitapin-prod-130623-133002.gz" root@139.59.52.53:/rit/smongo/action/

scp -i ~/.ssh/role-prod-imac "/Volumes/extraDrive/dcs_Drive/server/0-role-server-production/4-mongo-replication-ok/backup/devappapin-prod-130623-133002.gz" root@139.59.52.53:/rit/smongo/action/
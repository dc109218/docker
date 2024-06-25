openssl rand -base64 741 > /mongodb-build/auth/mongodb-keyfile

docker compose up -d

apt install jq -y

docker inspect --format "{{json .State.Health }}" router-01 | jq


scp -i ~/.ssh/role-prod-imac /Volumes/extraDrive/dcs_Drive/server/1-roleit-Production/2-Digitalocean-IN/5-mongo/backup/devappapin-prod-090423-191801.gz root@13.233.212.141:/rolemount/mongo/backup/
scp -i ~/.ssh/role-prod-imac /Volumes/extraDrive/dcs_Drive/server/1-roleit-Production/2-Digitalocean-IN/5-mongo/backup/liveroleitapin-prod-090423-191801.gz root@13.233.212.141:/rolemount/mongo/backup/

/Volumes/extraDrive/dcs_Drive/server/1-roleit-Production/2-Digitalocean-IN/5-mongo/backup/devappapin-prod-090423-191801.gz

liveroleitapin-prod-070423-135505.gz

rm -rf configsvr_1_data route_1_data  shard01_1_data shard02_1_data
mkdir -p configsvr_1_data route_1_data  shard01_1_data shard02_1_data
chmod 777 -R configsvr_1_data route_1_data  shard01_1_data shard02_1_data

rm -rf configsvr_2_data route_2_data  shard01_2_data shard02_2_data;mkdir -p configsvr_2_data route_2_data  shard01_2_data shard02_2_data;chmod 777 -R configsvr_2_data route_2_data  shard01_2_data shard02_2_data


rm -rf configsvr_3_data route_3_data  shard01_3_data shard02_3_data;mkdir -p configsvr_3_data route_3_data  shard01_3_data shard02_3_data;chmod 777 -R configsvr_3_data route_3_data  shard01_3_data shard02_3_data

docker compose up -d
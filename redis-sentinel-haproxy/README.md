# official link
https://www.linkedin.com/pulse/ha-redis-clustering-from-scratch-alexey-nizhegolenko/

# First, let's create all directories on these three nodes:
    # node1
    mkdir -p /rit/redis_ha/1role/{redis,haproxy} && mkdir /rit/redis_ha/1role/redis/data && cd /rit/redis_ha/1role/

    # node2
    mkdir -p /rit/redis_ha/2role/{redis,haproxy} && mkdir /rit/redis_ha/2role/redis/data && cd /rit/redis_ha/2role/

    # node3
    mkdir -p /rit/redis_ha/3role/{redis,haproxy} && mkdir /rit/redis_ha/3role/redis/data && cd /rit/redis_ha/3role/


# Create this config on all three nodes, the docker-compose file will be the same for all of them:

    # node1:/opt/redis_ha# 
        vi docker-compose.yml

    # cd /opt/redis_ha/redis 
    # node1:/opt/redis_ha/redis# 
        vi redis.conf

    
    # node2 cd /opt/redis_ha/redis
    # node2:/opt/redis_ha/redis# 
        vi redis.conf


    # node3 cd /opt/redis_ha/redis
    # node3:/opt/redis_ha/redis# 
        vi redis.conf

    # node1 cd /opt/redis_ha/redis
    # node1:/opt/redis_ha/redis# 
        vi sentinel.conf

    # node1# 
        chmod -R 777 /rolemount/redis_ha1/
        chmod -R 777 /rolemount/redis_ha1/sentinel

    # node2# 
        chmod -R 777 /rolemount/redis_ha2/redis
        chmod -R 777 /rolemount/redis_ha2/sentinel

    # node3# 
        chmod -R 777 /rolemount/redis_ha3/redis
        chmod -R 777 /rolemount/redis_ha3/sentinel



    # node1# 
        nano /etc/sysctl.conf

            net.ipv4.ip_forward=1
            net.ipv4.ip_nonlocal_bind=1

    # node2# 
        vi /etc/sysctl.conf

            net.ipv4.ip_forward=1
            net.ipv4.ip_nonlocal_bind=1

    node3# 
        vi /etc/sysctl.conf

            net.ipv4.ip_forward=1
            net.ipv4.ip_nonlocal_bind=1

    node1# 
        sysctl -p

    node2# 
        sysctl -p

    node3# 
        sysctl -p

    # node1:/opt/redis_ha/haproxy# 
        vi haproxy.cfg

    
# node1:/opt/redis_ha/# 
    docker-compose up -d
        Creating redis 
        Creating haproxy 
        Creating sentinel

# node2:/opt/redis_ha/# 
    docker-compose up -d
        Creating redis 
        Creating haproxy 
        Creating sentinel

# node3:/opt/redis_ha/# 
    docker-compose up -d
        Creating redis
        Creating haproxy
        Creating sentinel

# node1# 
    docker logs redis
# node1# 
    docker logs sentinel
# node1# 
    docker logs haproxy
    docker restart haproxy



# # node1# 
#     apt-get update && apt install -y keepalived
#     nano /etc/keepalived/keepalived.conf
#     systemctl enable keepalived;systemctl start keepalived;systemctl restart keepalived

# # node2# 
#     apt-get update && apt install -y keepalived
    systemctl status keepalived
#     nano /etc/keepalived/keepalived.conf
#     systemctl enable keepalived; systemctl start keepalived; systemctl restart keepalived

# # node3# 
#     apt-get update && apt install -y keepalived
#     nano /etc/keepalived/keepalived.conf
#     systemctl enable keepalived;systemctl start keepalived;systemctl restart keepalived

# check ip
    ip a
    redis-cli -h 10.10.10.10 -p 6380 -a yuanoh9ohgo4ahwohx
    redis-cli -h 10.0.1.238 -p 54321 -a yuanoh9ohgo4ahwohx
    redis-cli -h 10.0.102.211 -p 54322 -a yuanoh9ohgo4ahwohx

    # redis-cli -h 10.0.2.93 -p 54322
    # redis-cli -h 10.0.1.209 -p 54323

    -a yuanoh9ohgo4ahwohx
    
    docker run -it --rm redis redis-cli -a yuanoh9ohgo4ahwohx -h 192.168.1.10 -p 6380

systemctl stop keepalived
systemctl disable keepalived
apt remove keepalived -y 
apt-get remove --auto-remove keepalived -y 

====

scp /Volumes/extraDrive/dcs_Drive/server/1-roleit-Production/2-Digitalocean-IN/4-redis/data/appendonly070423.aof \
    -i ~/.ssh/role-prod-imac ubuntu@13.233.212.141:/rolemount/redis_ha1/redis/data/


curl -fsS http://127.0.0.1:6380/health
wget --quiet --tries=1 --spider http://127.0.0.1:6380/health; echo $?

docker inspect --format "{{json .State.Health }}" sentinel | jq

systemctl is-active network.service
systemctl start network.service

systemctl status network

service networking restart

sudo apt -y reinstall network-manager
/etc/init.d/network-manager start
systemctl restart systemd-networkd
systemctl enable network-manager.service
nmcli networking on


scp -i ~/.ssh/role-prod-imac /Volumes/extraDrive/dcs_Drive/server/1-roleit-Production/2-Digitalocean-IN/4-redis/data/appendonly100423.aof root@13.233.212.141:/rolemount/redis_ha3/redis/data/
scp -i ~/.ssh/role-prod-imac /Volumes/extraDrive/dcs_Drive/server/1-roleit-Production/2-Digitalocean-IN/4-redis/data/dump100423.rdb root@13.233.212.141:/rolemount/redis_ha3/redis/data/


===

scp -i ~/.ssh/role-prod-imac /Volumes/extraDrive/dcs_Drive/server/0-role-server-production/3-redis-sentinel-haproxy/backup/appendonly.aof root@139.59.52.53:/rit/redis_ha/3role/redis/data/

scp -i ~/.ssh/role-prod-imac /Volumes/extraDrive/dcs_Drive/server/0-role-server-production/3-redis-sentinel-haproxy/backup/dump.rdb root@139.59.52.53:/rit/redis_ha/3role/redis/data/
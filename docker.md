<!-- networks:
      role:
        ipv4_address: 192.168.1.6
networks:
  role:
    external: true -->

docker network create --driver=bridge --driver=bridge --subnet=192.168.1.0/16 role

docker inspect --format "{{json .State.Health }}" router-01 | jq`

cat << EOF > /etc/docker/daemon.json
{
    "features": { "buildkit": true },
    "insecure-registries" : ["registry.roleit.com:5443"],
    "allow-nondistributable-artifacts": ["registry.roleit.com:5443"]
}
EOF

systemctl restart docker

docker login registry.roleit.com:5443 -u username 2fc6b69fd858

===

url -fsS http://127.0.0.1:19111/healthcheck
wget --quiet --tries=1 --spider http://127.0.0.1/healthcheck; echo $?

docker inspect --format "{{json .State.Health }}" ffmpeg | jq


curl -fsS http://127.0.0.1:8080/healthcheck


curl -fsS http://13.233.212.141/healthcheck

ab -n 10000 -c 10 http://192.168.33.200/


kubectl create secret docker-registry roleit-tls \
  --docker-server=registry.roleit.com:5443 \
  --docker-username=dcsurani \
  --docker-password=a8298aef-5802-47a3-b7bf-2fc6b69fd858 \
  --docker-email=info@sareteam.com \
  --namespace=webrole


'/Volumes/extraDrive/dcs_Drive/=dinbin/ssl_certificate/roleit-com/roleit_com-ca-bundle.crt'

kubectl create secret generic registry-certificate --from-file=ca.crt=roleit_com-ca-bundle.crt --namespace=webrole

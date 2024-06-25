docker exec -it nginx bash -c "
"

Certificate is saved at:    /etc/letsencrypt/live/jobs.sare.in/fullchain.pem
Key is saved at:            /etc/letsencrypt/live/jobs.sare.in/privkey.pem

cp /etc/letsencrypt/live/jobs.sare.in/*.pem /etc/nginx/ssl/

===

epsyclinics.com

docker exec -it nginx bash -c "certbot --nginx -d epsyclinics.com -d www.epsyclinics.com -d graph.epsyclinics.com"

Certificate is saved at:    /etc/letsencrypt/live/jobs.sare.in/fullchain.pem
Key is saved at:            /etc/letsencrypt/live/jobs.sare.in/privkey.pem

cp /etc/letsencrypt/live/jobs.sare.in/*.pem /etc/nginx/ssl/


===

graph.atway.in www.atway.in atway.in
sudo certbot --nginx -d graph.atway.in -d www.atway.in -d atway.in

sudo nginx -t

systemctl restart nginx
FROM mongo:5.0.15-focal
RUN mkdir -p /dcs
COPY /auth/mongodb-keyfile /dcs
RUN chmod 400 /dcs/mongodb-keyfile
RUN chown 999:999 /dcs/mongodb-keyfile
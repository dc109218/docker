# dockerfile $TAG_DATE
FROM ubuntu:20.04

LABEL maintainer="dcsurani@gmail.com"

RUN mkdir /apps

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN ln -snf /usr/share/zoneinfo/Asia/Calcutta /etc/localtime && echo Asia/Calcutta > /etc/timezone

VOLUME ["/apps/logs", "/apps/token"]

WORKDIR /apps

RUN dpkg --add-architecture i386
RUN apt-get update -y

# Download specific python3 (all packages).
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y python3-pip

ADD requirements.txt /apps/
RUN pip3 install -r requirements.txt
COPY . /apps

# Clean up
RUN apt-get clean
RUN apt-get purge

RUN ln -s /apps/main.sh /usr/bin/programstoryvl

EXPOSE 11111

CMD ["programstoryvl"]
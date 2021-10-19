FROM openjdk:16-slim

MAINTAINER tracedgod <bowestrace@gmail.com>

run apt-get update \
&& apt-get install -y wget \
&& apt-get install -y jq \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir /papermc \
&& groupadd --gid 5000 paper \
&& useradd --uid 5000 \
--gid 5000 paper -s /bin/bash \
&& chown 5000:5000 /papermc -R

USER 5000

ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    MC_RAM="" \
    JAVA_OPTS=""

COPY papermc.sh .

CMD ["sh", "./papermc.sh"]

EXPOSE 25565/tcp
EXPOSE 25565/udp
VOLUME /papermc

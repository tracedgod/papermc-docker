# Created by tracedgod. https://github.com/tracedgod
# Pull openjdk image from Docker Hub
FROM openjdk:21-slim

# Install required apps and cleanup + create non-root user with GID 5000
RUN apt-get update \
&& apt-get dist-upgrade -y \
&& apt-get install -y wget \
&& apt-get install -y jq \
&& apt-get install -y nano \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& mkdir /papermc \
&& groupadd --gid 5000 paper \
&& useradd --uid 5000 \
--gid 5000 paper -s /bin/bash \
&& chown 5000:5000 /papermc -R

# Set runtime user to non-root user
USER 5000

# Create ENV variables
ENV MC_VERSION="latest" \
    PAPER_BUILD="latest" \
    MC_RAM="" \
    JAVA_OPTS=""

# Copy papermc script to image
COPY papermc.sh .

# Set image CMD to papermc script
CMD ["sh", "./papermc.sh"]

# Expose ports in image neccesary for PaperMC Server
EXPOSE 25565/tcp
EXPOSE 25565/udp
EXPOSE 25575/tcp
EXPOSE 25575/udp
# Create /papermc volume in image
VOLUME /papermc

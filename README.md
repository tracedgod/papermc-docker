![Logo](https://miro.medium.com/max/617/1*v9KNKSA_Pz4lywnXWNh1SQ.png)


# PaperMC-Docker
A Docker image for setting up a PaperMC Minecraft Server. This image is based off of openjdk:17-slim from Docker Hub for minimal resources required for a Minecraft Server to run.

# Instructions

Firstly, you will need to have Docker on your machine that you will be running the container on. If you do not have it installed, follow the guide [here](https://docs.docker.com/get-docker/) and select your Operating System of choice.

For convieneince, I have uploaded the built image to Docker Hub for easy configuration. You can pull down the image from Docker Hub by typing in `docker pull tracedgod/papermc` into your terminal/cmd window.

Once the image is downloaded, type `docker run -p 25565:25565 tracedgod/papermc` into your terminal/cmd window. This is the minimum required to start up a new PaperMC server, however there are also several environment options that can be set as well.

### Container Flags

- Port
  - This option is __required__. By default, Minecraft servers run off of port `25565`, Use this port number if you are unsure of what port you are using.
  - If you are planning to use RCON, this option must be specified a second time for port `25575`.
  - *__default port config flag:__* `-p <port-of-choice>:25565`
  - *__RCON enabled port config flag:__* `-p <port-of-choice>:25565 -p <port-of-choice>:25575`
> *Note: change the __"port-of-choice"__ to the the desired port, using 25565 as default (25575 for RCON).*

- Volume
  - Use this to set a name for the Docker container's volume.
  - Alternatively, you can set this to an absolute path that points to a folder and mount it to the container.
  - `-v <my_volume_name>:/papermc`
  - `-v </path-to-files>:/papermc`

- Detached
  - If you want to create the container without attaching to it, use this flag to allow the container to independently run from your current terminal session.
  - `-d`

- Terminal/Console
  - If you will need to access the server's command line, include these flags to use `docker attach` and input commands.
  - These flags can be specified separately, or as one option.
  - `-t` and `-i` in any order
  - `-ti` or `-it`

- Restart Policy
  - If you include this, the container will automatically restart if it crashes.
  - Stopping the server from the container command line will also stop the container itself.
  - Another option is to automatically restart the container unless you manually stop it with `docker stop <container-id>`
  - It is highly recommended to only stop the server from its console __*(not via Docker)*__.
  - `--restart on-failure`
  - `--restart unless-stopped`

- Name
  - Use this to set a name for your newly created container.
  - This will allow for easier configuration while it is running, I highly recommend using this.
  - `--name "<my-container-name>"`

### Environment Variables

- Minecraft Version
  - **Name:** `MC_VERSION`
  - Set this to the Minecraft version that the server should support.
  - Note: there must be a PaperMC release for the specified version of Minecraft.
  - If this is not set, the latest version supported by PaperMC will be used.
  - Changing this on an existing server will change the version *without wiping the server*.
  - `-e MC_VERSION="<latest>"`
- PaperMC Build
  - **Name:** `PAPER_BUILD`
  - Set this to the number of the PaperMC build that the server should use (**not the Minecraft version**).
  - If this is not set, the latest PaperMC build for the specified `MC_VERSION` will be used.
  - Changing this on an existing server will change the version *without wiping the server*.
  - `-e PAPER_BUILD="<latest>"`
- RAM
  - **Name:** `MC_RAM`
  - Set this to the amount of RAM the server can use.
  - Must be formatted as a number followed by `M` for "Megabytes" or `G` for "Gigabytes".
  - If this is not set, Java allocates its own RAM based on total system/container RAM.
  - `-e MC_RAM="<4G>"`
- Java options
  - **Name:** `JAVA_OPTS`
  - **ADVANCED USERS ONLY**
  - Set to any additional Java command line options that you would like to include.
  - By default, this environment variable is set to the empty string.
  - `-e JAVA_OPTS="<-XX:+UseConcMarkSweepGC -XX:+UseParNewGC>"`

### Building
  - To build, clone this git repo with `git clone https://github.com/tracedgod/papermc-docker.git` into your terminal/cmd window.
  - Change directory to newly cloned repo with `cd papermc-docker`
  - Begin building the image with `docker build .`
  - Once completed, the image will not be tagged, so you can tag it with `docker tag <container-id> <your-new-tag>`

### Docker-Compose
  - I have included a template `docker-compose.yml` in the github repo for convienience. You may also view the file below:
```yaml
version: "3.8"

services:
   papermc:
     # Change container_name to desired name.
     container_name: papermc
     hostname: papermc
     image: tracedgod/papermc:latest
     # For docker attach functionality, both stdin_open and tty must be set to true.
     stdin_open: true
     tty: true
     ports:
       - '25565:25565/tcp'
      # Uncomment below line for RCON functionality.
      # - '25575:25575/tcp'
     environment:
       # Change below env variables to desired values, default for MC_VERSION + PAPER_BUILD is latest, MC_RAM + JAVA_OPTS are optional.
       - MC_VERSION=latest
       - PAPER_BUILD=latest
       - MC_RAM=
       - JAVA_OPTS=
     restart: unless-stopped
     volumes:
      # Uncomment + Change this to server files path. For rw access on host, create a new group with GID 5000 and add yourself to said group.
      # - '<path-to-server-volume>:/papermc'
```

## Credits

  - [Phyremaster](https://github.com/Phyremaster/papermc-docker) for the `papermc.sh` script + variables.

## Links 

  - [Docker Hub Link](https://hub.docker.com/r/tracedgod/papermc)

>__*I am **NOT** affiliated with PaperMC in any way. [Here](https://papermc.io/) is a link to the PaperMC site.*__

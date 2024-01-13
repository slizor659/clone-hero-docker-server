# Clone Hero Docker Server

Repository for docker server files for a dedicated Clone Hero server.

This is a fork, see the credits for information on the original build.

Hosted on Docker Hub here: https://hub.docker.com/r/racketyphilly5k/clone-hero-server-final

## Usage

Pull image using:

```docker pull racketyphilly5k/clone-hero-server-final:latest```

Run image using:

```docker run racketyphilly5k/clone-hero-server-final:latest```

## Startup Configuration

By default, the image will expose port 14242, which is the default used in Clone Hero. Changing that will require you to edit the EXPOSE line in the Dockerfile and rebuild the image (to my knowledge).

The inital setup configuration has the following:

* Name of server = Clone Hero Docker Server
* Password of server = test
* IP of server = 0.0.0.0 (The official Clone Hero server executable says not to touch this if unnecessary, so you should be able to leave this)
* Port of server = 14242 (The official Clone Hero server executable says not to touch this if unnecessary, so you should be able to leave this)

To change the inital setup configuration (name, password, IP, ports) of the Clone Hero server, you can do so with environment variables like below:

```docker run -e NAME='Name of Server displayed in CH' -e PASS='password' -e IP='ip.of.server.if.not.default' -e PORT='portassigned' racketyphilly5k/clone-hero-server-final:latest```

You can also do so in Docker Desktop by adding environment variables using NAME, PASS, IP, and PORT as the names for each respective value.

### YOU MUST HAVE A PASSWORD ASSIGNED. DEFAULT IS test

## Server Configuration

The default configuration of the server after starting up is to allow:

* 4 simulatneous players
* 8 spectators
* Each player can select up to 4 songs per setlist
* All players can remove songs from setlist

You may change this by downloading this repository and manually editing the settings.ini file to your hearts content.

## Sidenote

The original intention of this fork was so I could personally host a dedicated server on a TrueNAS SCALE server, and it is confirmed to be working. In order to do so, you must manually forward the port in the inital setup of the container in the WebGUI, and all environment variables can also be changed within said GUI.

The port should be UDP, and the environment variables must be added one at a time.

## Credits

This is a fork of Cory Sanin's original build that has been updated and reconfigured for Clone Hero Final.

The original source is located here: https://gitlab.com/CorySanin/clone-hero-server-docker 

The original Docker Hub is located here: https://hub.docker.com/r/corysanin/clone-hero-server

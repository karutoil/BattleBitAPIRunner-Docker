[![Docker Pulls](https://img.shields.io/docker/pulls/hedius/bbrapirunner.svg?style=flat-square)](https://hub.docker.com/r/hedius/bbrapirunner/)
# BattleBitAPIRunner Docker
A docker image for the latest [BBRAPIRunner](https://github.com/BattleBit-Community-Servers/BattleBitAPIRunner) release.

Permissions
The image runs with UID and GID 5000 (non-root).
Make sure that all files within volumes are owned by that user.

## Usage
Image: `hedius/bbrapirunner:latest`

1. clone the repo / or download the example docker-compose.yml
2. `mkdir data`
3. `docker compose up -d`


### Docker Compose
```yml
services:
  bbr-api:
    image: hedius/bbrapirunner:latest
    restart: unless-stopped
    ports:
      - "29294:29294"
    tty: true
    volumes:
      ./data:/app/data 
      # - type: volume
      #   source: bbr
      #   target: /app/data

# volumes:
#   bbr:
```

### Port
The application is listening on port `29294` by default.

### Volumes / Data
All data should be stored in `/app/data` which is a volume.

Within this volume data is stored at the following paths:
* Modules: `./modules`
* Dependencies: `./dependencies`
* Configurations: `./configurations`

### Other Stuff
You can modify the configuration of the application by mounting the config to `/app/appsettings.json`.

# License
GPLv3
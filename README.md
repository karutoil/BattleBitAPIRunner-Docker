[![Docker Pulls](https://img.shields.io/docker/pulls/hedius/bbrapirunner.svg?style=flat-square)](https://hub.docker.com/r/hedius/bbrapirunner/)
# BattleBitAPIRunner Docker
A docker image for the latest BBRAPIRunner release.

 Permissions
The image runs with UID and GID 5000 (non-root).
Make sure that all files within volumes are owned by that user.

## Usage
Image: `hedius/bbrapirunner:latest`

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

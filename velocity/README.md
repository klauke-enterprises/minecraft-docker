# velocity-docker
Easy to use and clean Docker image for running Velocity servers in Docker containers using OpenJDK. 

You may also be interested in [waterfall-docker](https://github.com/klauke-enterprises/minecraft-docker/tree/dev/waterfall) 
and [paper-docker](https://github.com/klauke-enterprises/minecraft-docker/tree/dev/paper) 
if you want to build a whole server network.

# Getting started
The easiest way for a quick start would be:
```bash
docker run -it \
    -p 25565:25565 \
    -v ~/minecraft/data:/opt/minecraft/data \
    klauke-enterprises/velocity:3.1.1
```

# Tags and Versions
The Docker images are tagged for their Minecraft versions. These versions are currently available:
- `ghcr.io/klauke-enterprises/velocity:3.1.2-SNAPSHOT`
- `ghcr.io/klauke-enterprises/velocity:3.1.1-SNAPSHOT`
- `ghcr.io/klauke-enterprises/velocity:3.1.1`
- `ghcr.io/klauke-enterprises/velocity:3.1.0`
- `ghcr.io/klauke-enterprises/velocity:1.1.9`
- `ghcr.io/klauke-enterprises/velocity:1.0.10`

All images will update at nightly builds.

# Volumes
There is one volume which is seperated and used for:
- Plugins
- Config files (velocity.toml)
- Logs

You can find the mount location in `docker-compose.yml`.

# docker-compose.yml
## Bind Mounts
This method is recommended if you have an already existing server which you wish to run inside a container [due to
the way bind mounts behave.](https://docs.docker.com/storage/bind-mounts/#mount-into-a-non-empty-directory-on-the-container)
You can add this simple entry to your docker-compose.yml when using bind mounts:
```yaml
version: '3.9'

services:
  velocity:
    image: ghcr.io/klauke-enterprises/velocity:3.1.1
    container_name: velocity
    stdin_open: true
    tty: true
    restart: always
    networks:
      - minecraft
    ports:
      - 25565:25565
    volumes:
      - ./data:/opt/minecraft/data

networks:
  minecraft: {}

```

## Volumes
If you want to use explicit volumes, you can use this:
```yaml 
version: '3.9'

services:
  velocity:
    image: ghcr.io/klauke-enterprises/velocity:3.1.1
    container_name: velocity
    stdin_open: true
    tty: true
    restart: always
    networks:
      - minecraft
    ports:
      - 25565:25565
    volumes:
      - velocity-data:/opt/minecraft/data

volumes:
  velocity-data: 

networks:
  minecraft: {}

```

# See Also
- [Docker CLI Reference: docker cp](https://docs.docker.com/engine/reference/commandline/cp/) - Copy files/folders between 
a container and the local filesystem. Useful if you want to add new plugins, change settings, etc.
- [Docker CLI Reference: docker attach](https://docs.docker.com/engine/reference/commandline/attach/) - Attach to a
running container. Will attach to the server's console directly, allowing you to issue commands. 

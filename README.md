# paperspigot-docker
Easy to use and clean Docker image for running Paper Spigot servers in Docker containers using OpenJDK. 

You may also be interested in [waterfall-docker](https://github.com/FelixKlauke/waterfall-docker) and [velocity-docker](https://github.com/FelixKlauke/velocity-docker) if you want to build a whole server network.

# Getting started
The easiest way for a quick start would be:
```bash
docker run -it \
    -p 25565:25565 \
    -v ~/minecraft/data:/opt/minecraft/data \
    klauke-enterprises/paperspigot:1.16.5
```

# Tags and Versions
The Docker images are tagged for their Minecraft versions. These versions are currently available:
- `ghcr.io/klauke-enterprises/paper-docker:1.16.5`
- `ghcr.io/klauke-enterprises/paper-docker:1.16.4`
- `ghcr.io/klauke-enterprises/paper-docker:1.16.3`
- `ghcr.io/klauke-enterprises/paper-docker:1.16.2`
- `ghcr.io/klauke-enterprises/paper-docker:1.16.1` 
- `ghcr.io/klauke-enterprises/paper-docker:1.15.2` 
- `ghcr.io/klauke-enterprises/paper-docker:1.15.1` 
- `ghcr.io/klauke-enterprises/paper-docker:1.15` 
- `ghcr.io/klauke-enterprises/paper-docker:1.14.4` 
- `ghcr.io/klauke-enterprises/paper-docker:1.14.3` 
- `ghcr.io/klauke-enterprises/paper-docker:1.14.2` 
- `ghcr.io/klauke-enterprises/paper-docker:1.14.1` 
- `ghcr.io/klauke-enterprises/paper-docker:1.14`
- `ghcr.io/klauke-enterprises/paper-docker:1.13.2` 
- `ghcr.io/klauke-enterprises/paper-docker:1.13.1`
- `ghcr.io/klauke-enterprises/paper-docker:1.13`
- `ghcr.io/klauke-enterprises/paper-docker:1.12.2`
- `ghcr.io/klauke-enterprises/paper-docker:1.12.1`
- `ghcr.io/klauke-enterprises/paper-docker:1.12`
- `ghcr.io/klauke-enterprises/paper-docker:1.11.2`
- `ghcr.io/klauke-enterprises/paper-docker:1.10.2`
- `ghcr.io/klauke-enterprises/paper-docker:1.9.4`
- `ghcr.io/klauke-enterprises/paper-docker:1.8.8`

The specific images are updated by hand. The 1.x-latest images will update at nightly builds and will always
use the latest build.

# Volumes
There is one volume which is seperated and used for:
- Worlds
- Plugins
- Config files (paper.yml, bukkit.yml, spigot.yml, server.properties, commands.yml,
 banned-ips.json, banned-players.json, help.yml, ops.json, permissions.yml, whitelist.json)
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
  minecraft:
    image: ghcr.io/klauke-enterprises/paper-docker:1.16.5
    container_name: minecraft
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
  minecraft:
    image: ghcr.io/klauke-enterprises/paper-docker:1.16.5
    container_name: minecraft
    stdin_open: true
    tty: true
    restart: always
    networks:
      - minecraft
    ports:
      - 25565:25565
    volumes:
      - minecraft-data:/opt/minecraft/data

volumes:
  minecraft-data: 

networks:
  minecraft: {}

```

# See Also
- [Docker CLI Reference: docker cp](https://docs.docker.com/engine/reference/commandline/cp/) - Copy files/folders between 
a container and the local filesystem. Useful if you want to add new plugins, change settings, etc.
- [Docker CLI Reference: docker attach](https://docs.docker.com/engine/reference/commandline/attach/) - Attach to a
running container. Will attach to the server's console directly, allowing you to issue commands. 

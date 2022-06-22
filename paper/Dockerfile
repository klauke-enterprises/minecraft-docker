ARG JAVA_VERSION=16

FROM openjdk:${JAVA_VERSION} AS build
LABEL maintainer="Klauke Enterprises <info@klauke-enterprises.com>"

ARG PAPER_VERSION=1.17
ARG BUILD_VERSION=79
ARG DOWNLOAD_VERSION="paper-1.17-79.jar"
ARG PAPER_DOWNLOAD_URL=https://api.papermc.io/v2/projects/paper/versions/${PAPER_VERSION}/builds/${BUILD_VERSION}/downloads/${DOWNLOAD_VERSION}
ENV MINECRAFT_BUILD_PATH=/opt/minecraft

WORKDIR ${MINECRAFT_BUILD_PATH}

ADD ${PAPER_DOWNLOAD_URL} paper.jar

RUN java -jar ${MINECRAFT_BUILD_PATH}/paper.jar; exit 0

FROM openjdk:${JAVA_VERSION}-buster AS runtime
LABEL maintainer="Klauke Enterprises <info@klauke-enterprises.com>"

ENV MINECRAFT_PATH=/opt/minecraft

ENV SERVER_PATH=${MINECRAFT_PATH}/server
ENV DATA_PATH=${MINECRAFT_PATH}/data

ENV LOGS_PATH=${DATA_PATH}/logs
ENV CONFIG_PATH=${DATA_PATH}/config
ENV WORLDS_PATH=${DATA_PATH}/worlds
ENV PLUGINS_PATH=${DATA_PATH}/plugins

ENV PROPERTIES_LOCATION=${CONFIG_PATH}/server.properties

ENV JAVA_HEAP_SIZE=4G
ENV JAVA_ARGS="-Dcom.mojang.eula.agree=true -Dfile.encoding=UTF-8"
ENV SPIGOT_ARGS="--nojline"
ENV PAPER_ARGS=""


COPY --from=build /opt/minecraft/paper.jar ${SERVER_PATH}/

ADD scripts/docker-entrypoint.sh ${MINECRAFT_PATH}/docker-entrypoint.sh
RUN chmod +x ${MINECRAFT_PATH}/docker-entrypoint.sh


# Create symlink for plugin volume as hotfix for some plugins who hard code their directories
RUN ln -s $PLUGINS_PATH $SERVER_PATH/plugins && \
    ln -s $WORLDS_PATH $SERVER_PATH/worlds && \
    ln -s $LOGS_PATH $SERVER_PATH/logs && \
    ln -s $CONFIG_PATH/banned-ips.json $SERVER_PATH/banned-ips.json && \
    ln -s $CONFIG_PATH/banned-players.json $SERVER_PATH/banned-players.json && \
    ln -s $CONFIG_PATH/help.yml $SERVER_PATH/help.yml && \
    ln -s $CONFIG_PATH/ops.json $SERVER_PATH/ops.json && \
    ln -s $CONFIG_PATH/permissions.yml $SERVER_PATH/permissions.yml && \
    ln -s $CONFIG_PATH/whitelist.json $SERVER_PATH/whitelist.json && \
    ln -s $CONFIG_PATH/server-icon.png $SERVER_PATH/server-icon-png

RUN mkdir -p ${SERVER_PATH} ${LOGS_PATH} ${CONFIG_PATH} ${WORLDS_PATH} ${PLUGINS_PATH}


ADD https://bootstrap.pypa.io/pip/2.7/get-pip.py .
RUN python get-pip.py

RUN pip install mcstatus
RUN apt-get update && apt-get install htop

HEALTHCHECK --interval=10s --timeout=5s --start-period=90s \
  CMD mcstatus localhost:25565 ping


EXPOSE 25565
VOLUME "${DATA_PATH}"

WORKDIR ${MINECRAFT_PATH}
ENTRYPOINT [ "./docker-entrypoint.sh" ]

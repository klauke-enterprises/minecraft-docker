ARG JAVA_VERSION=16

FROM openjdk:${JAVA_VERSION} AS build
LABEL maintainer="Klauke Enterprises <info@klauke-enterprises.com>"

ARG VELOCITY_VERSION=3.1.1
ARG BUILD_VERSION=102
ARG DOWNLOAD_VERSION="velocity-3.1.1-102.jar"
ARG VELOCITY_DOWNLOAD_URL=https://api.papermc.io/v2/projects/velocity/versions/${VELOCITY_VERSION}/builds/${BUILD_VERSION}/downloads/${DOWNLOAD_VERSION}
ENV MINECRAFT_BUILD_PATH=/opt/minecraft

WORKDIR ${MINECRAFT_BUILD_PATH}

ADD ${VELOCITY_DOWNLOAD_URL} velocity.jar


FROM openjdk:${JAVA_VERSION}-buster AS runtime
LABEL maintainer="Klauke Enterprises <info@klauke-enterprises.com>"

ENV MINECRAFT_PATH=/opt/minecraft

ENV SERVER_PATH=${MINECRAFT_PATH}/server
ENV DATA_PATH=${MINECRAFT_PATH}/data

ENV LOGS_PATH=${DATA_PATH}/logs
ENV CONFIG_PATH=${DATA_PATH}/config
ENV PLUGINS_PATH=${DATA_PATH}/plugins

ENV TOML_LOCATION=${CONFIG_PATH}/velocity.toml

ENV JAVA_HEAP_SIZE=4G
ENV JAVA_ARGS="-Dfile.encoding=UTF-8"
ENV VELOCITY_ARGS=""


COPY --from=build /opt/minecraft/velocity.jar ${SERVER_PATH}/

ADD scripts/docker-entrypoint.sh ${MINECRAFT_PATH}/docker-entrypoint.sh
RUN chmod +x ${MINECRAFT_PATH}/docker-entrypoint.sh


# Create symlink for plugin volume as hotfix for some plugins who hard code their directories
RUN ln -s $PLUGINS_PATH $SERVER_PATH/plugins && \
    ln -s $LOGS_PATH $SERVER_PATH/logs && \
    ln -s $CONFIG_PATH/velocity.toml $SERVER_PATH/velocity.toml && \
    ln -s $CONFIG_PATH/server-icon.png $SERVER_PATH/server-icon.png

RUN mkdir -p ${SERVER_PATH} ${LOGS_PATH} ${CONFIG_PATH} ${PLUGINS_PATH}


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

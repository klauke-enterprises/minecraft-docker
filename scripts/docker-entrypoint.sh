#!/bin/sh
set -e

exec java \
  $JAVA_ARGS \
  -Xmx$JAVA_HEAP_SIZE -Xms$JAVA_HEAP_SIZE \
  -jar $SERVER_PATH/paper.jar \
  $SPIGOT_ARGS \
  -c $PROPERTIES_LOCATION \
  -b $CONFIG_PATH/bukkit.yml \
  -P $PLUGINS_PATH \
  -W $WORLDS_PATH \
  -S $CONFIG_PATH/spigot.yml \
  -C $CONFIG_PATH/commands.yml \
  --paper $CONFIG_PATH/paper.yml \
  $PAPERSPIGOT_ARGS
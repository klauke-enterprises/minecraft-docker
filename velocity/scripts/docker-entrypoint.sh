#!/bin/sh
set -e

exec java \
  $JAVA_ARGS \
  -Xmx$JAVA_HEAP_SIZE -Xms$JAVA_HEAP_SIZE \
  -jar $SERVER_PATH/velocity.jar \
  $VELOCITY_ARGS
#!/bin/bash
CONTAINER_ID=$(docker run -P --name officeContainer-$(date +%s) --cap-add=SYS_ADMIN --device=/dev/fuse -d -P \
  -e SPICE_PASSWD=abc123 \
  -e AMQP_BUS_HOST=localhost \
  -e LANG=da_DK \
  -e COMMAND_TO_EXECUTE="['node', '/root/start.js', 'writer']" -e SPICE_RES=1024x768 -e EYEOS_UNIX_USER=user open365-office)
echo "CONTAINER: $CONTAINER_ID"

# Wait for X to startup
sleep 10

# Run LibreOffice on DISPLAY 2 (used for SPICE)
docker exec $CONTAINER_ID bash -c "DISPLAY=:2 /usr/lib/libreoffice/program/soffice --writer" &

docker ps

docker logs -f $CONTAINER_ID

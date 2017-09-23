#!/bin/bash
export IMAGE=logstash-queue-corruption
set -e

docker build -t $IMAGE .
docker ps -aqf "label=scope=test" | xargs docker rm -f >/dev/null 2>&1 || true
id=$(docker run --label scope=test -d $IMAGE)
echo "Started container $id"

while ! docker exec $id curl -fs http://127.0.0.1:8888; do
  echo 'Waiting for http input to become ready...'
  sleep 2
done

i=1
while [[ $i -le 5 ]]; do
  echo "[$i] Send normal int must be OK"
  docker exec $id curl \
    -XPOST -H 'content-type: application/json' \
    -fs -d '{ "int": 32000 }' \
    http://127.0.0.1:8888
  let i=i+1
done

echo '####'
echo '#### SENDING BIGINT AND CORRUPTING THE QUEUE'
echo '####'

docker exec $id curl \
  -XPOST -H 'content-type: application/json' \
  -fs -d '{ "int": 9223372036854776000 }' \
  http://127.0.0.1:8888

echo '####'
echo '#### LOGSTASH IS DEAD NOW, WILL WORK NO MORE'
echo '####'
docker logs $id

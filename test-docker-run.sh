#!/bin/bash
cmd-config(){
  cat > ~/powerstrip-demo/adapters.yml <<EOF
endpoints: {}
adapters: {}
EOF
}

cmd-ps(){
  docker run -d \
    --name powerstrip \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v ~/powerstrip-demo/adapters.yml:/etc/powerstrip/adapters.yml \
    -p 2375:2375 \
    clusterhq/powerstrip
  sleep 2
}

cmd-normal-echo(){
  echo "SOCKET: unix:///var/run/docker.sock"
  DOCKER_HOST=unix:///var/run/docker.sock docker run --rm ubuntu echo hello
}

cmd-ps-echo(){
  echo "SOCKET: tcp://127.0.0.1:2375"
  DOCKER_HOST=tcp://127.0.0.1:2375 docker run --rm ubuntu echo hello
}

cmd-logs(){
  docker logs powerstrip
}

cmd-cleanup(){
  docker stop powerstrip
  docker rm powerstrip
}

cmd-config
cmd-ps
cmd-normal-echo
cmd-ps-echo
cmd-logs
cmd-cleanup
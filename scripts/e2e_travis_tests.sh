#!/bin/bash

#Load dependency (bash unit testing framework)
#https://github.com/lehmannro/assert.sh
source ./scripts/assert.sh

# Build docker
docker build -t azure_function_image .
docker run -p 80:80 --sysctl net.ipv6.conf.all.disable_ipv6=1 --name azure_function_image azure_function_image &
sleep 40

#e2e test
echo "Asserts"
assert "curl localhost:80/api/HttpTrigger-Java -d Azure" "Hello, Azure"

#cleanup
docker ps -a
docker stop azure_function_image
docker rm azure_function_image
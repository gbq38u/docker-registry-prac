#!/bin/bash

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}=== Docker Resource Limits Test ===${NC}"
echo -e "${BLUE}This script will help you test resource limits on your containers${NC}"
echo

echo -e "${YELLOW}Test 1: Checking CPU limits${NC}"
echo "Running 'docker stats' 5 times to observe CPU usage..."
for i in {1..5}; do
    docker stats --no-stream api-service data-processor background-service limited-db
    echo
    sleep 2
done
echo

echo -e "${YELLOW}Test 2: Checking memory limits${NC}"

for container in api-service data-processor background-service limited-db; do
    echo -e "${BLUE}Container: $container${NC}"
    docker exec "$container" sh -c "cat /sys/fs/cgroup/memory.max" 2>/dev/null || \
    docker exec "$container" sh -c "cat /sys/fs/cgroup/memory/memory.limit_in_bytes" 2>/dev/null || \
    echo -e "${RED}Could not access memory limits for $container${NC}"
    echo
done

echo -e "${YELLOW}Test 3: Checking I/O limits for limited-db${NC}"
echo "I/O limits are harder to verify directly, but we can check the configuration:"
docker inspect --format='{{json .HostConfig.BlkioDeviceReadBps}}' limited-db
docker inspect --format='{{json .HostConfig.BlkioDeviceWriteBps}}' limited-db
echo

echo -e "${GREEN}=== Tests completed ===${NC}"
echo -e "${BLUE}Для более детального мониторинга вы можете использовать 'docker stats'${NC}"

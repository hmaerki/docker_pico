set -x
set -e

docker build --tag docker_pico_sdk .
docker run --rm -it --hostname=pico-sdk docker_pico_sdk
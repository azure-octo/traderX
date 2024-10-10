#! /usr/bin/env bash
set -eu

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 myregistry.com/mypath/"
    exit 1
fi

REGISTRY=$1
TAG=${2:-latest}

declare -a IMAGES=(
    sql-database
    reference-data
    trade-feed
    people-service
    account-service
    position-service
    trade-service
    trade-processor
    ingress
)

for IMAGE in "${IMAGES[@]}"
do
   docker build $IMAGE -t "$REGISTRY/$IMAGE:$TAG"
done

docker build web-front-end/angular -t "$REGISTRY/web-front-end-angular:$TAG"

for IMAGE in "${IMAGES[@]}"
do
   docker push "$REGISTRY/$IMAGE:$TAG"
done

docker push "$REGISTRY/web-front-end-angular:$TAG"

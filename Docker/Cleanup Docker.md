# Cleanup Docker

## Built-in

Remove all unused containers, networks, images (both dangling and unreferenced), and volumes.

```bash
docker system prune --all
docker system prune --volumes
```

## Helper

Provide more granular control on the age of items to delete.

```bash
df -h
docker rm $(docker ps -qa --no-trunc --filter "status=exited")
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock yelp/docker-custodian dcgc --dry-run --max-container-age 1days --max-image-age 1minute
docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock yelp/docker-custodian dcgc --max-container-age 1days --max-image-age 1minute
docker volume rm $(docker volume ls -qf dangling=true)
docker ps -a
```

```bash
df -h
docker rm (docker ps -qa --no-trunc --filter "status=exited")
docker rmi (docker images --filter "dangling=true" -q --no-trunc)
docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock yelp/docker-custodian dcgc --dry-run --max-container-age 1days --max-image-age 1minute
docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock yelp/docker-custodian dcgc --max-container-age 1days --max-image-age 1minute
docker volume rm (docker volume ls -qf dangling=true)
docker ps -a
```

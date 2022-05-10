# Docker images for Builds

These are docker images used to build, compile, and base other software on.

| OS | Variants |
|---|----------|
| [https://hub.docker.com/r/charlesportwoodii/alpine/tags](Alpine)] |  3.14, 3.15 |
| [https://hub.docker.com/r/charlesportwoodii/ubuntu/tags](Ubuntu)] | 18.04, 20.04, 22.04 |

Packages are cross-build using buildx for x86_64 and ARM64 via buildx

Buildx:

```
docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
docker buildx create --name multiarch --driver docker-container --use
docker buildx inspect --bootstrap
docker run --privileged --rm tonistiigi/binfmt --install all
```

Re-apply as needed. Drone can sometimes fail due to buildx breaking.

```
docker buildx build -f ubuntu/22.04/Dockerfile.build --push --platform linux/arm64,linux/amd64 -t charlesportwoodii/ubuntu:22.04-build --compress --squash  .
```
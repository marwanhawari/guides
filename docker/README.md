# Docker guide

## Basics
1. Pulling an image from a docker registry: `docker pull <image>:<tag>`
2. Build an image from Dockerfile in current directory and tag it: `docker build -t <image>:<tag> .`
3. Pushing an image to a registry: `docker push <username>/<image>:<tag>`
4. Run docker container in the background using the `-d` option: `docker run -d <image>:<tag>`
5. Publish a host port to a port exposed in a container using the `-P` or `-p`.
    * The `-P` flag will automatically publish an available, high-number port on your host machine for every port exposed with the `EXPOSE` keyword in the Dockerfile.
      * `docker run -P <image>:<tag>`
    * The `-p` flag allows you to specify the ports directly when you launch the container. If you use the `-p` flag, you don't need to explicitly use `EXPOSE` in the Dockerfile.
      * `docker run -p <hostPort>:<containerPort> <image>:<tag>`
7. List your local images: `docker images`
   * After pushing to a remote registry, your image is automatically assigned a digest. You can view images and their digests using: `docker images --digests`.
8. List your running containers: `docker ps`
   * List all containers `docker ps -a`
9. Remove an image: `docker rmi <image>`
10. Remove a container: `docker rm <container>`

## Dockerfile
* RUN, ADD, and COPY all add layers to the Dockerfile (and thus increase image size), so try to minimize the number of RUN, ADD, and COPY commands.
* Never run the docker container as root. You can do all the set up and config of the Docker file as root but you want to execute the final commands as a non-root user.

## Extra
1. Clear the build cache using: `docker builder prune`
1. Run an interactive bash shell with the `python:3.9` image: `docker run -it --rm python:3.9 bash`
    * It will automatically download the image if you don't already have it
    * `--rm`: deletes the container after you exit
    * `-i`: Keep STDIN open even if not attached
    * `-t`: Allocate a pseudo-tty
    * `bash` is the cmd
 1. This works because the `python:3.9` image has a `CMD` as its last line, however if the Dockerfile has an `ENTRYPOINT`, this won't work. You can override the entrypoint by using the `--entrypoint` flag. It also works if you have a `CMD` as the last line: `docker run -it --rm --entrypoint bash python:3.9`
    * You can override both the entrypoint and the cmd at the same time: `docker run --entrypoint <executable-entrypoint> python:3.9 <arguments-for-entrypoint>`
        * For example `docker run --entrypoint ls python:3.9 -lhrta ..`
1. Run `docker system prune` to clean up docker images. This will remove:
    - all stopped containers
    - all networks not used by at least one container
    - all dangling images
    - all dangling build cache

# GitHub container registry
1. Authenticate using: `echo $GITHUB_TOKEN | docker login ghcr.io -u <username> --password-stdin`
2. Build your image with the `ghcr.io` namespace: `docker build -t ghcr.io/<username>/<image>:<tag> .`
   * Ex: `docker build -t ghcr.io/marwanhawari/ghget:v0.1.0 .`
4. Push your image `docker push ghcr.io/<username>/<image>:<tag>`
   * Ex: `docker push ghcr.io/marwanhawari/ghget:v0.1.0`

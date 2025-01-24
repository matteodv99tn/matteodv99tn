# Useful Docker Scripts

## Automatic container start 
The following is simple, yet effective, bash script which enables to

- creates a new container (with a user-defined name) based on the designated Docker image;
- if the container is already running, it simply attaches to it;
- if the container appears to be stopped, it starts and attaches to it.

This script assumes implicitly that the Docker image is already present in the system, and if that is not the case, it will exit with an error message.
However, one might easily extend the script to pull the image if it is not available, or build it from source with a designed Dockerfile.

``` bash
#!/bin/bash
DOCKER_IMAGE="ubuntu:22.04"  # Chose the desired images
CONTAINER_NAME=""            # Set the container name

# Ensure that image is available
if [[ -z  "$(docker images -q $DOCKER_IMAGE 2> /dev/null)"  ]]; then
    echo "Image $DOCKER_IMAGE not found"
    echo "Make sure you have the image available before running this script"
    exit 1
fi

# Check if container is already running
if [[ -n "$(docker ps -q -f name=$CONTAINER_NAME)" ]]; then
    echo "Container $CONTAINER_NAME is already running, attaching to it.."
    docker exec -it $CONTAINER_NAME /bin/bash
else
    # Check if container is stopped
    if [[ -n "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]]; then
        echo "Container $CONTAINER_NAME is stopped, starting it.."
        docker start $CONTAINER_NAME
        docker exec -it $CONTAINER_NAME /bin/bash
    else
        echo "Container $CONTAINER_NAME not found, creating and starting it.."
        # Add aruments as needed here
        docker run \
            -it \
            --name $CONTAINER_NAME \
            $DOCKER_IMAGE /bin/bash
    fi
fi
```

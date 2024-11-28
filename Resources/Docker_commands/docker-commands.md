```dockerfile
# Use a Java 17 base image
FROM openjdk:17-jdk-slim

# Maintainer information
MAINTAINER albertprofe

# Copy the application JAR file to the container
COPY restaurant-0.0.1-SNAPSHOT.jar restVaadin.jar

# Set the entry point to run the JAR file
ENTRYPOINT ["java", "-jar", "restVaadin.jar"]
```

```bash
docker login
docker build -t restvaadinapp .
docker run -p 8080:8080 restvaadinapp
```

| Command        | Flag            | Description                                                          |
| -------------- | --------------- | -------------------------------------------------------------------- |
| `docker build` | `-t, --tag`     | Assigns a name and optionally a tag (e.g., `name:tag`) to the image. |
| `docker build` | `-f, --file`    | Specifies the Dockerfile to use if it's not named `Dockerfile`.      |
| `docker build` | `--build-arg`   | Passes build-time variables to the Dockerfile.                       |
| `docker build` | `--no-cache`    | Ignores cached layers and forces a fresh build.                      |
| `docker build` | `--target`      | Builds a specific stage in a multi-stage Dockerfile.                 |
| `docker build` | `-q, --quiet`   | Suppresses output, showing only the final image ID.                  |
| `docker run`   | `-d, --detach`  | Runs the container in detached mode (in the background).             |
| `docker run`   | `-p, --publish` | Maps container ports to host ports (e.g., `8080:80`).                |
| `docker run`   | `--name`        | Assigns a name to the container for easier reference.                |
| `docker run`   | `-e, --env`     | Sets environment variables inside the container.                     |
| `docker run`   | `--rm`          | Automatically removes the container when it exits.                   |
| `docker run`   | `-v, --volume`  | Mounts host directories or volumes into the container.               |
| `docker run`   | `--network`     | Connects the container to a specified network.                       |
| `docker run`   | `--cpus`        | Limits the number of CPUs available to the container.                |
| `docker run`   | `--memory`      | Sets a memory limit for the container.                               |

```bash
# Build a Docker image from the current directory's Dockerfile
# -t: Tag the image with the name 'myapp' and version '1.0'
docker build -t myapp:1.0 .

# Run a new container from the 'myapp' image
# -d: Run the container in detached mode (in the background)
# --name: Assign the name 'myapp_container' to the container
# -p: Map port 8080 on the host to port 80 in the container
docker run -d --name myapp_container -p 8080:80 myapp:1.0

# List all running containers
docker ps

# Show logs from 'myapp_container'
# -f: Follow log output in real-time
docker logs -f myapp_container

# Display real-time statistics for all running containers
docker stats

# Stop the 'myapp_container'
docker stop myapp_container

# Remove the stopped 'myapp_container'
docker rm myapp_container

# Remove the 'myapp' image
docker rmi myapp:1.0

# Clean up unused Docker resources (containers, networks, images)
docker system prune -f
```

## Mapping Multiple Ports

When you want to map multiple ports, you simply specify the `-p` option multiple times in your `docker run` command. Here is an example:

```bash
`docker run -d --name my_container -p 8080:80 -p 8443:443 nginx`
```

## Explanation

- **`-d`**: Runs the container in detached mode (in the background).
- **`--name my_container`**: Assigns the name `my_container` to the running container.
- **`-p 8080:80`**: Maps port 80 in the container to port 8080 on the host. This is typically used for HTTP traffic.
- **`-p 8443:443`**: Maps port 443 in the container to port 8443 on the host. This is commonly used for HTTPS traffic

## Steps to Add a User to the Docker Group

1. **Create the Docker Group (if it doesn't exist)**:- Run the following command to create the `docker` group if it hasn't been created already:bash
   
    `sudo groupadd docker`

2. **Add Your User to the Docker Group**:- Add your user to the `docker` group using the following command. Replace `${USER}` with your username if you're not using an environment variable:bash
   
    `sudo usermod -aG docker ${USER}`

3. **Apply Changes**:- Log out and log back in so that your group membership is re-evaluated.
   
   - Alternatively, you can use the following command to apply the changes without logging out:bash
     
     `newgrp docker`

4. **Verify Docker Access**:
   
   - Test your Docker setup by running a simple command like `docker ps` without `sudo`:bash
     
     `docker ps`
   
   - If this command runs successfully without errors, your setup is complete.

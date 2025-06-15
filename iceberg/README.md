# Apache Iceberg

This repository contains a Docker Compose stack with notebooks demonstrating how to work with Apache Iceberg tables on top of AWS S3. It spawns following services:

- a Jupyter notebook environment that includes PySpark, Polars and DuckDB (https://jupyter.org/)
- a single-node Trino cluster (https://trino.io/)
- an instance of Lakekeeper catalog (https://lakekeeper.io/)
- a MinIO storage service, compatible with AWS S3 and used as the underlying storage (https://min.io/)

### Requirements

The only required component is `docker` and `docker-compose`, which can be downloaded as a single package from https://www.docker.com/products/docker-desktop. Shortcut scripts prepared in this repository assume that a *nix operating system is being used, offering one of the standard shell environments like `sh` or `bash`.

**On Windows**

In order to use the contents of this repository on Windows, WSL (Windows Subsystem for Linux) is required. In addition to that, an option in Docker Desktop to integrate with WSL needs to be enabled.

**All commands described here should be executed from the main folder of the repository.**

### Project Structure

The structure of the folders and files in this project is as follows:

```
+- ./_data/      # stores data generated when working with provided notebooks
+- ./_notebooks/ # Jupyter notebooks with examples and exercises
+- ./docker/     # definitions of Docker images and the Docker Compose stack
+- ./dbuild      # build command (see below)
+- ./dclean      # clean command (see below)
+- ./drun        # run command (see below)
```

To understand how each service is configured to work together, please familiarise yourself with the `./docker/docker-compose.yaml` file, as well as with `Dockerfile` definitions and configuration files in subfolders responsible for each of the services.

### Preparations

Build Docker images (it may take some time):

```sh
./dbuild
```

### Running and Testing

The Docker Compose stack can be started with:

```sh
./drun
```

After the stack is up, following UIs can be accessed in the browser:

- the Jupyter environment at http://localhost:8888, with notebooks in `/_notebooks/`
- the Trino UI at http://localhost:8080 (any user name will do)
- the MinIO console at http://localhost:9001 (user: `minioadmin`, password: `minioadmin`)

To verify that everything works, try executing cells in the notebook called `00_test_and_prepare.ipynb`, one by one.

### Cleanup

All Docker containers and images can be removed by running:

```sh
./dclean
```

Afterwards the images will have to be rebuilt from scratch if necessary. Additionally, to remove data files generated during the execution of the notebooks, delete all subfolders in `./_data/`.

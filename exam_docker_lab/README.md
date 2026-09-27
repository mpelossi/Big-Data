# Exam Docker Magic Box

This folder contains the Docker setup for the exam and the exercise sheets. Exercises can be found in the [course GitHub repository](https://github.com/RumbleDB/bigdata-exercises).

## Prerequisites

Ensure you have Docker and Docker Compose installed on your system. If not, please download and install them from [Docker's official website](https://www.docker.com/products/docker-desktop/).

## Setup

1. **Starting the Containers**: Activate the Docker environment for the exercise sheet by executing `docker compose up -d`. Please note that this command runs the containers in the background.
2. **Accessing Logs**: If you wish to see logs or outputs, you can use `docker compose logs`.
3. **Shutdown**: Once you're done, you can stop and remove the containers with the `docker compose down` command.

## Jupyter Notebook

1. **Adding Exercise Sheets**: To add an exercise sheet to the Docker environment, simply drag its notebook file into the `notebooks` folder.
2. **Accessing Jupyter**: Once you've started the containers, open your browser and navigate to [localhost:8888](https://localhost:8888).

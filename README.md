# docker-ansible

This repository provides a minimal setup to run terraform from inside a Docker container.

Contents

- `Dockerfile`: builds an image based on `ubuntu:latest` with `terraform`installed. The container copies `main.tf` and `variables.tf` and runs `terraform init`, `terraform plan` and `terraform apply`.
- `terraform init`:
    - download the right tools.
- `terraform plan`: 
    - says what it changes
- `terraform apply`:
    - apply the configuration

Usage

1. Build the Docker image:

```bash
docker build -t docker-terraform .
```

2. Run the container (you will be prompted for the SSH password):

```bash
docker run --rm -it \
  -v "$PWD/main.tf:/terraform/main.tf:ro" \
  -v "$PWD/variables.tf:/terrafrom/variables.tf:ro" \
  docker-ansible
```

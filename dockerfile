FROM ubuntu:latest

# Install packages
RUN apt-get update && apt-get install -y terraform

# Create terraform directory
WORKDIR /terraform

# Copy files
COPY main.tf .
COPY variables.tf .

# terraform plan
CMD ["terraform", "init"] && ["terraform", "plan"] && ["terraform", "apply", "-auto-approve"]
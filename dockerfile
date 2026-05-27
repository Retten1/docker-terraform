FROM ubuntu:latest

# Install packages
RUN apt update && apt install -y wget gnupg lsb-release
RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt update && apt install -y terraform

# Create terraform directory
WORKDIR /terraform

# Copy files
COPY main.tf .
COPY variables.tf .

# terraform plan
CMD ["terraform", "init"] && ["terraform", "plan"] && ["terraform", "apply", "-auto-approve"]
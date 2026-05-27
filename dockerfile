FROM ubuntu:latest

# Install packages
RUN sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
RUN sudo apt-get update && sudo apt-get install -y terraform

# Create terraform directory
WORKDIR /terraform

# Copy files
COPY main.tf .
COPY variables.tf .

# terraform plan
CMD ["terraform", "init"] && ["terraform", "plan"] && ["terraform", "apply", "-auto-approve"]
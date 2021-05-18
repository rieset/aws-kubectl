FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update -y && apt-get install -y curl unzip groff jq bc

# Download and unzip install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && /
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN unzip awscliv2.zip

# Run AWS install
RUN ./aws/install

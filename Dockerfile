FROM gcr.io/google.com/cloudsdktool/google-cloud-cli:stable

LABEL org.label-schema.name="Kubernates tools" \
      org.label-schema.description="Kubernates tools" \
      org.label-schema.schema-version="3.0" \
      org.label-schema.author="Albert Iblyaminov" \
      org.opencontainers.image.source="https://github.com/rieset/kubernates-tools"

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update -y && apt-get install -y curl unzip groff jq bc nodejs npm

# Download and unzip install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN unzip awscliv2.zip

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

# Run AWS install
RUN ./aws/install

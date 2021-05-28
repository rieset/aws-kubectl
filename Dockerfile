FROM gcr.io/google.com/cloudsdktool/cloud-sdk:latest

LABEL org.label-schema.vendor="AWS tools with kubectl" \
      org.label-schema.name="AWS tools with kubectl" \
      org.label-schema.description="AWS tools with kubectl" \
      org.label-schema.schema-version="1.0" \
      org.opencontainers.image.source="https://github.com/rieset/kubernates-tools"

ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update -y && apt-get install -y curl unzip groff jq bc

# Download and unzip install
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl
RUN unzip awscliv2.zip

RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh

RUN helm plugin install https://github.com/reactiveops/autohelm
    
RUN curl -L https://github.com/Praqma/helmsman/releases/download/v3.7.0/helmsman_3.7.0_linux_amd64.tar.gz | tar zx && \
    mv helmsman /usr/local/bin/helmsman    

# Run AWS install
RUN ./aws/install

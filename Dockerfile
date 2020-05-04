FROM ubuntu:bionic
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND noninteractive
ENV NODE_VERSION 12.14.0

EXPOSE 9005

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openssh-client=1:7.6p1-4ubuntu0.3 \
    apt-transport-https=1.6.12 \
    ca-certificates=20180409 \
    curl=7.58.0-2ubuntu3.8 \
    gnupg-agent=2.2.4-1ubuntu1.2 \
    software-properties-common=0.96.24.32.12 \
    ruby-dev=1:2.5.1 \
    git=1:2.17.1-1ubuntu0.7 \
    python=2.7.15~rc1-1 \
    build-essential=12.4ubuntu1 \
    hugo=0.40.1-1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

## Install node
ENV NVM_DIR=/root/.nvm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash 
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" &&  nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
RUN cp -a $NVM_DIR/versions/node/v${NODE_VERSION}/* /usr/local/ 

## Install Firebase
RUN npm install -g firebase-tools@latest
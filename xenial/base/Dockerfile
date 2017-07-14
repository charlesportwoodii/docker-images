FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Charles R. Portwood II <charlesportwoodii@erianna.com>

# Install pre-dependencies
RUN apt-get update && apt-get install wget apt-transport-https curl -y

# Add our deb repository
RUN sh -c 'echo "deb https://deb.erianna.com xenial main" > /etc/apt/sources.list.d/deb.erianna.com.list'

# Install GNUPG2 for ECDSA key support
RUN apt-get --allow-unauthenticated update && \
    apt-get --allow-unauthenticated install gnupg2 gnutls3 -y && \
    ldconfig

# Download & install ECC signing keys for the repository
RUN wget --quiet -O - https://gist.githubusercontent.com/charlesportwoodii/702abdf8dae5164f4917e78cf256a480/raw/afa856ff3e1ca2205c5ffeed943bbbaea79b4944/398ECFC4.pub | apt-key add - && \
    wget -qO - https://gist.githubusercontent.com/charlesportwoodii/6cc11c2b7ca50932a81049d9e1a1d027/raw/91f82a3a9d7b427daa30413160489f008c735799/761B989F0120C4444DF755C094F981FCCA91BE86.pub | apt-key add -

# Clean the repository data
RUN apt-get update && \
    apt-get clean -y && \
    apt-get autoclean -y && \
    apt-get purge -y --auto-remove && \
    rm -rf /var/lib/apt/lists/*

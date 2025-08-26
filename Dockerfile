FROM debian:latest

RUN apt-get update && \
    apt-get install -y git wget build-essential libncurses-dev autoconf make && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/dotfiles
WORKDIR /root/dotfiles

ENTRYPOINT ["bash", "-l"]
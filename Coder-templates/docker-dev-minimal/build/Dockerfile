FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y \
    sudo \
    curl \
    git \
    vim \
    nano \
    openssh-client \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ARG USER=coder
RUN useradd --groups sudo --no-create-home --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" >/etc/sudoers.d/${USER} \
    && chmod 0440 /etc/sudoers.d/${USER}

USER ${USER}
WORKDIR /home/${USER}

RUN mkdir -p /etc/skel/.config/opencode
COPY opencode.json /etc/skel/.config/opencode/opencode.json

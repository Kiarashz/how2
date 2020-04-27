# Example command for creating the image:
#
# docker build . -t mydev:2020-02 --build-arg username=myname
#

FROM debian:latest
ARG username=developer
RUN export DEBIAN_FRONTEND=noninteractive && \
apt update && \
apt install -y ansible sudo vim yamllint kdiff3 git sshpass krb5-user krb5-kdc python3-pip python-dev libkrb5-dev tmux jq wget curl unzip zip && \
rm -rf /var/lib/apt/lists/*

# Install PowerShell
COPY install-powershell.sh /tmp/
RUN sh /tmp/install-powershell.sh

COPY --chown=root:root krb5.conf /etc/krb5.conf

# create user to run container as
RUN useradd -m ${username} -s /bin/bash && \
echo "${username} ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/${username} && \
chmod 660 /etc/sudoers.d/${username}

VOLUME [ "/home" ]
USER ${username}
WORKDIR /home/${username}

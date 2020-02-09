username=kiarash
echo "$username ALL = (ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$username
sudo apt update
sudo apt install curl tmux vim git
curl get.sdkman.io | bash
curl -L https://git.io/n-install | bash
skd install java 15.ea.8-open
skd install maven
skd install gradle
sudo addgroup --system docker
sudo usermod -aG docker $username
sudo apt update && sudo apt install docker.io

# below may need update over time
cat > /tmp/daemon.json << EOF
{
    "insecure-registries" : ["172.30.0.0/0"]
}
EOF
sudo mv /tmp/daemon.json /etc/docker/daemon.json

# install openshift https://github.com/openshift/origin/releases
curl -L -o /tmp/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz \ 
https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz


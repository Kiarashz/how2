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
sudo snap install docker

# below may need update over time
cat > /tmp/daemon.json << EOF
{
    "log-level":        "error",
    "storage-driver":   "overlay2",
    "insecure-registries" : ["172.30.0.0/0"]
}
EOF
sudo mv /tmp/daemon.json /var/snap/docker/423/config/daemon.json

# install openshift

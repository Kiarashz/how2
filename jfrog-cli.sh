# install jfrog cli
wget -qO - https://releases.jfrog.io/artifactory/api/gpg/key/public | sudo apt-key add -;
echo "deb https://releases.jfrog.io/artifactory/jfrog-debs xenial contrib" | sudo tee -a /etc/apt/sources.list;
sudo apt install -y jfrog-cli;

# configure remote JFrog server
jfrog config add
jfrog config show
jfrog rt ping --server-id=myArtifactory

# Move artifacts
jfrog rt mv  test-results/TestRunResults_202104*.zip test-results/2021/04/

# Upload artifacts
jfrog rt u --flat=false --server-id server1 prebuilds/ pre_builds/

# Download artifacts
jfrog rt dl prebuilds/ pb/

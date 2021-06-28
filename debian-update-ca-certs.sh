mkdir -p /usr/share/ca-certificates/myCA
sudo cp ca1.pem /usr/share/ca-certificates/myCA
sudo echo "myCA/ca1.pem" >> /etc/ca-certificates.conf
update-ca-certificates

mkdir -p /usr/share/ca-certificates/myCA
sudo cp ca1.pem /usr/share/ca-certificates/myCA
sudo echo "myCA/ca1.pem" >> /etc/ca-certificates.conf
update-ca-certificates

# to split ca files into separate crt files:
cat multiple_cacerts.pem | awk 'split_after==1{n++;split_after=0} /-----END CERTIFICATE-----/ {split_after=1} {print > "/usr/local/share/ca-certificates/my_cacert" n ".crt"}'

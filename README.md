### Useful commands

#### Using GPG to share secrets
```
# Install GPG (sender and Recipient) 
sudo apt install gnupg 
 
# Generate key (Recipient) 
gpg --full-generate-key 
 
# Export public Key (Recipient) 
gpg --armor --export your.email@example.com > public-key.asc 

# Import the public key (sender) 
gpg --import public-key.asc 

# Encrypt the secret (sender) 
echo "your-secret-password" > password.txt 
gpg --armor --encrypt --recipient Recipient@example.com password.txt 

# Decrypt the secret (Recipient) 
gpg --decrypt password.txt.asc
```

#### OpenSSL commands to create certificates
    # Create CA certificate and key
    openssl req -new -x509 -days 3650 -extensions v3_ca -keyout private/cakey.pem -out cacert.pem
    
    # Create Certificate Signing Request
    $ openssl req -new -nodes -out example.com.csr -keyout private/example.com.key
    
    # Create extension file
    cat > example.com.ext << EOF
    authorityKeyIdentifier=keyid,issuer
    basicConstraints=CA:FALSE
    keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
    subjectAltName = @alt_names

    [alt_names]
    DNS.1 = example.com
    EOF
    
    # Sign CSR file using CA key/certificate
    openssl x509 -req -in example.com.csr \
    -CA cacert.pem -CAkey private/cakey.pem \
    -CAcreateserial -out example.com.crt \
    -days 500 -sha256 -extfile example.com.ext
    
# Open SSL Convert
    openssl x509 -inform DER -in ssl_certificate.cer -out ssl_certificate.cr
    openssl pkcs12 -export -out my-cert-and-key.pfx -inkey key.pem -in cert.pem --passin pass:changeit --passout pass:changeit -name "alias to be set in here"
    openssl pkcs7 -inform der -in a.p7b -out a.cer
    openssl pkcs7 -inform der -in a.p7b -print_certs -out a.pem
    
    openssl x509 -inform der -in cert.crt -out cert.pem
    
    # convert Windows CRL to PEM
    openssl crl -in your_current.crl -inform DER -out crl.pem
    # view text content
    openssl crl -in crl.pem  -noout -text
    

# GNome swithc to windows on the same workspace only
    gsettings set org.gnome.shell.app-switcher current-workspace-only true


# Update java CACerts
    keytool -import -noprompt -cacerts -storepass changeit -alias alias-for-self-generated-ca-cert -file /path/to/ca.der.or.cer.file

# Install packages on Debian using not-very-well-mirrored repository
    apt --allow-unauthenticated --allow-insecure-repositories update 
    apt install -y --allow-unauthenticated
# Configure PIP for private CA and mirrored Pypi
    pip3 config set global.cert my-ca-chain.pem 
    pip3 config set global.index-url https://my-mirrored-repository/simple 
    pip3 config set global.timeout 90 

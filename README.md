### Repo to store settings that normally needed after OS installation

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

# GNome swithc to windows on the same workspace only
gsettings set org.gnome.shell.app-switcher current-workspace-only true
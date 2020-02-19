## Build image locally using S2I
    s2i build . -E .\.s2i\environment -v C:\certificates\my-ca.pem:/tmp/myca.pem centos/nodejs-10-centos7:latest my-app-image-name

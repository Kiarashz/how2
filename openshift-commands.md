## Build image locally using S2I
    s2i build . -E .\.s2i\environment -v C:\certificates\my-ca.pem:/tmp/myca.pem centos/nodejs-10-centos7:latest my-app-image-name

## MERN deploy via S2I 
To deploy applications to OpenShift there are few options [build strategies](https://docs.openshift.com/container-platform/3.11/dev_guide/builds/index.html) available including S2I. The following are steps to take for a MERN application but the concept can be applied for other languages.

First, if the Builder image (docker image) your application depends on (Node 8 is the latest available in OpenShift 3.11) is not available in OpenShift, you need to pull the builder image (from CentOS docker repository or any other trusted repositories) or create one.


    # Pulling Node 10 Builder Image
    docker pull centos/nodejs-10-centos7


    # Or build the image that meets S2I requirements
    git clone git@github.com:sclorg/s2i-nodejs-container.git
    cd s2i-nodejs-container/10
    docker build . -t myrepo_url/myaccount/my-nodejs-10-centos7:<correct version matching exact node version>


Push the image into your trusted docker registry. You can push the image into OpenShift internal registry if accessible.


    docker login myrepo_url
    docker push myrepo_url/myaccount/my-nodejs-10-centos7:<correct version matching exact node version>


If image has not been pushed into OpenShift internal registry, import it from the one you pushed into


    oc import-image --from myrepo_url/myaccount/my-nodejs-10-centos7:<correct version matching exact node version> --confirm [--insecure=true]


Make sure your source code is in source repository accessible from OpenShift. If required add .s2i folder with required files (environment, assemble, run, ...) if you need to customize the S2I builder scripts.


    # Example environment file content
    NPM_MIRROR=https://my-npm-mirror/
    NODE_EXTRA_CA_CERTS=/path/to/my/custom/ca/certificate

    # Example assemble script to overwrite the one built into S2I image
    . . .
    # Copy My Company CA certificate
    curl -Lko ${CA_PATH:-'/path/to/my/custom/ca/certificate'} ${CA_URL:-'url-to-my-custom-ca-certificate'}
    . . .



Create secret to access source code. If using GitHub, add public key into the repository where the code should be cloned from. [This guide](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.1/html/builds/creating-build-inputs) has more details on this.


    oc create secret generic <secret_name> \
        --from-file=ssh-privatekey=<path/to/ssh/private/key> \
        --type=kubernetes.io/ssh-auth


Find the builder image name imported into OpenShift on step 3. ((nodejs-10-centos7 as shwon below)



    $ oc get is

    NAME                DOCKER REPO                                               TAGS               UPDATED
    nodejs-10-centos7   docker-registry.default.svc:5000/nova/nodejs-10-centos7   10.16.3.2,latest   21 hours ago
    . . .



Deploy your application using the builder image and URL to source code. You will face issues with the build process on OpenShift if using SSH auth or non-valid certificates at source repository server that can be solved following [this guide](https://blog.openshift.com/private-git-repositories-part-2b-repository-ssh-keys/).


    oc new-app --name my-application nodejs-10-centos7~git@my-repo-url.git


    # If SSH auth is configured fix build failure 
    oc set build-secret --source bc/<build name> <secret name>


Verify that everything worked


    oc get all

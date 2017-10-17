# k8s-SSH-Client

Base on alpine.

This image contain a k8s client - kubectl and running the sshd daemon.

You can use this to connect to the kubernetes cluster. We use this to push our kube configs to cluster and check the syntaxis of them.

For syntaxis check you can use. You need to mount the config file from kubernetes

    kubectl -f /path --dry-run=true

or our nodeapp 

    # node /k8s-sync-check/app.js
    Files syntaxis is okay
    / # echo $?
    0

the app check the folder, that was defined in env var "RESSPATH"

# Usage

    sudo docker run -d -e RESSPATH="/ressources" -e ROOT_PASS="rootw" -p 30000:22 \ 
        -v /nodejs/k8s-sync-check/authorized_keys:/root/.ssh/authorized_keys \
        -v /nodejs/k8s-sync-check/config:/root/.kube/config \
        -v /nodejs/k8s-sync-check/ressources:/ressources \
        --name k8s-sync -t adito/k8s-sync

# Variables

**RESSPATH**  - path to the folder of yaml files, this var will be used from node app.

    Structure
      folder:
        configFolder:
          *.yaml
        configFolder2:
          *.yaml

**ROOT_PASS** - root pass, DEFAULT is "root" (witout "")

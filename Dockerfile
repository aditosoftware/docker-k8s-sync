FROM node:8.7-alpine

COPY app.js /k8s-sync-check/app.js
COPY package.json /k8s-sync-check/package.json
COPY run.sh /run.sh
COPY supervisor.ini /etc/supervisor.d/supervisor.ini

RUN apk update && \
    apk add openssh-server openrc supervisor curl bash && \
    curl https://storage.googleapis.com/kubernetes-release/release/v1.8.0/bin/linux/amd64/kubectl -o /usr/sbin/kubectl && \
    chmod +x /usr/sbin/kubectl && \
    /usr/bin/ssh-keygen -A && \
    mkdir -p /root/.kube && \
    mkdir -p /root/.ssh && \
    mkdir -p /etc/supervisor.d && \
    mkdir -p /k8s-sync-check && \
    cd /k8s-sync-check && \
    npm install && \
    cp -a /etc/ssh /etc/ssh.cache && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    rm -rf /var/cache/apk/*

EXPOSE 22

CMD ["/run.sh"]
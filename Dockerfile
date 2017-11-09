FROM node:8.7-alpine

COPY app.js /k8s-sync-check/app.js
COPY package.json /k8s-sync-check/package.json
COPY run.sh /run.sh
COPY supervisor.ini /etc/supervisor.d/supervisor.ini
ADD https://storage.googleapis.com/kubernetes-release/release/v1.8.2/bin/linux/amd64/kubectl /usr/sbin/

RUN apk update && \
    apk add openssh-server openssh-client rsync supervisor fish mdocml-apropos bash && \
    chmod +x /usr/sbin/kubectl && \
    /usr/bin/ssh-keygen -A && \
    mkdir -p /root/.kube && \
    mkdir -p /root/.ssh && \
    mkdir -p /etc/supervisor.d && \
    mkdir -p /k8s-sync-check && \
    cd /k8s-sync-check && \
    npm install && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    chmod +x /run.sh && \
    rm -rf /var/cache/apk/*

EXPOSE 22

CMD ["/run.sh"]

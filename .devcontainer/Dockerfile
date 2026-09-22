FROM cruizba/ubuntu-dind:noble-29.7.2

ENV DEBIAN_FRONTEND=noninteractive \
    GOLANG_VERSION=1.27.0 \
    PATH="/usr/local/go/bin:/root/go/bin:${PATH}" \
    GOPATH=/root/go \
    EDITOR="code -w"

# OS setup
RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        curl \
        sudo \
        git \
        jq \
        wget \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# K8s setup
RUN curl -fsSL -o /tmp/minikube \
        https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && install -o root -g root -m 0755 /tmp/minikube /usr/local/bin/minikube \
    && rm /tmp/minikube

RUN curl -fsSL -o /tmp/kubectl \
        "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 /tmp/kubectl /usr/local/bin/kubectl \
    && rm /tmp/kubectl

# Go setup
RUN wget -q "https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" \
    && tar -C /usr/local -xzf "go${GOLANG_VERSION}.linux-amd64.tar.gz" \
    && rm "go${GOLANG_VERSION}.linux-amd64.tar.gz"

# GO CLIs
RUN go install github.com/bootdotdev/bootdev@latest \
    && echo 'export PATH=$PATH:$HOME/go/bin' >> /root/.bashrc

# Entrypoint
COPY .devcontainer/cgroup-nesting-entrypoint.sh cgroup-nesting-entrypoint.sh
ENTRYPOINT [ "./cgroup-nesting-entrypoint.sh" ]

CMD ["sleep", "infinity"]

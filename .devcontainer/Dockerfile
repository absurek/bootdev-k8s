FROM docker:29.7.2-dind

# os setup
RUN apk add --no-cache bash curl sudo git jq wget

# k8s setup
RUN curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
&& install minikube-linux-amd64 /usr/local/bin/minikube \
&& rm minikube-linux-amd64

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
&& install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
&& rm kubectl

# Go setup
ENV GOLANG_VERSION=1.27.0

RUN wget -q https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-amd64.tar.gz && \
    rm go${GOLANG_VERSION}.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# GO CLIs
RUN go install github.com/bootdotdev/bootdev@latest && \
    echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc

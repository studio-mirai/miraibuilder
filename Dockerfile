FROM ubuntu:24.04

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \    
    curl \
    git \
    libclang-dev \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup default stable

RUN curl -L https://github.com/peak/s5cmd/releases/download/v2.3.0/s5cmd_2.3.0_Linux-64bit.tar.gz -o /tmp/s5cmd.tar.gz
RUN tar -xzf /tmp/s5cmd.tar.gz -C /usr/local/bin
RUN rm /tmp/s5cmd.tar.gz

COPY build.sh /app/build.sh
RUN chmod +x /app/build.sh

CMD ["bash", "/app/build.sh"]
FROM ubuntu:latest as builder
RUN apt-get update && apt-get upgrade -y && apt-get install -y curl
RUN curl -OL https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.1.5/dnscrypt-proxy-linux_x86_64-2.1.5.tar.gz
RUN tar xf ./dnscrypt-proxy-linux_x86_64-2.1.5.tar.gz
RUN mv ./linux-x86_64/dnscrypt-proxy /bin/dnscrypt-proxy

FROM alpine
COPY --from=builder /bin/dnscrypt-proxy /bin/dnscrypt-proxy
CMD ["/bin/dnscrypt-proxy", "-config", "/etc/dnscrypt-proxy.toml"]

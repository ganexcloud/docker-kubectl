FROM alpine:3.18
MAINTAINER Ganex <suporte@ganex.com.br>

# Arguments
ARG KUBECTL_VERSION="v1.27.7"

# Install dependecies
RUN set -ex \
  && apk update -qq \
  && apk add --update ca-certificates curl jq

# Install kubectl
RUN set -ex \
  && curl -sSL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl

# Create a user and group used to launch processes
RUN addgroup -g 1000 -S app \
  && adduser -u 1000 -D -S -s /sbin/nologin -G app app

# Start
USER 1000
ENTRYPOINT [ "kubectl" ]
CMD [ "--help" ]
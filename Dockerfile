# Use a imagem base do Alpine Linux
FROM alpine:latest

# Informações sobre o mantenedor
LABEL maintainer="Seu Nome <seu.email@example.com>"

# Versão do OpenShift Client desejada
ENV OC_VERSION=v4.12.0

# Download e instalação do OpenShift Client
RUN apk --no-cache add curl &&
    wget https://github.com/alexandrezanetti/image-pipeline/raw/main/oc-4.14.6-linux.tar.gz &&
    ls -lia &&
    ls -lia /usr/local/bin/ &&
    tar -xzvf oc-4.14.6-linux.tar.gz -C /usr/local/bin/ &&
    apk del curl

# Ponto de entrada padrão
ENTRYPOINT ["oc"]

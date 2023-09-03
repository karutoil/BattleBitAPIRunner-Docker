# Docker BattleBitRunner Image
# user and group ID of the account for full read/write access
FROM mcr.microsoft.com/dotnet/sdk:6.0
ARG FILE="BattleBitAPIRunner.zip"
ARG DONOTCACHE="NOT CACHING"

RUN apk add --no-cache --update curl ca-certificates openssl git tar bash sqlite fontconfig \
    && adduser --disabled-password --home /home/container container

RUN apt update && \
    apt install -y unzip curl && \
    rm -rf /var/lib/apt/lists/*

USER container
ENV  USER=container HOME=/home/container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

LABEL maintainer="Hedius @ github.com/hedius" \
      description="BattleBitRunner Docker image"


RUN echo $DONOTCACHE && \
    export VERSION=$(curl -s https://api.github.com/repos/BattleBit-Community-Servers/BattleBitAPIRunner/releases/latest | grep tag_name | cut -d '"' -f 4) && \
    curl https://github.com/BattleBit-Community-Servers/BattleBitAPIRunner/releases/download/$VERSION/$VERSION.zip -L -o $FILE  && \
    unzip -x $FILE && \
    rm $FILE && \
    mkdir -p data/dependencies data/modules data/configurations

CMD ["/bin/bash", "/entrypoint.sh"]

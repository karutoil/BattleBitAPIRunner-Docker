# Docker BattleBitRunner Image
# user and group ID of the account for full read/write access
FROM mcr.microsoft.com/dotnet/sdk:6.0
ARG UID=5000
ARG GID=5000
# ToDo automatically get latest version
ARG VERSION="0.4.7"
ARG FILE="BattleBitAPIRunner.zip"
ARG DLURL="https://github.com/BattleBit-Community-Servers/BattleBitAPIRunner/releases/download/$VERSION/$VERSION.zip"

LABEL maintainer="Hedius @ github.com/hedius" \
      description="BattleBitRunner Docker image" \
      version="$version"

 # account for execution
RUN groupadd -r -g $GID bbr && \
    useradd -r -g bbr -u $UID bbr

WORKDIR /app

RUN apt-get update && \
    apt-get install -y unzip wget && \
    rm -rf /var/lib/apt/lists/* && \
    wget -O $FILE $DLURL && \
    unzip -x $FILE && \
    rm $FILE && \
    mkdir -p data/dependencies data/modules data/configurations && \
    chown bbr:bbr -R /app

COPY --chown=bbr:bbr ./appsettings.json /app

USER bbr:bbr


VOLUME ["/app/data"]
EXPOSE 29294

ENTRYPOINT ["dotnet", "BattleBitAPIRunner.dll"]

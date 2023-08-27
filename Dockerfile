# Docker BattleBitRunner Image
# user and group ID of the account for full read/write access
FROM mcr.microsoft.com/dotnet/sdk:6.0
ARG UID=5000
ARG GID=5000
ARG FILE="BattleBitAPIRunner.zip"

LABEL maintainer="Hedius @ github.com/hedius" \
      description="BattleBitRunner Docker image"

 # account for execution
RUN groupadd -r -g $GID bbr && \
    useradd -r -g bbr -u $UID bbr

WORKDIR /app

RUN apt update && \
    apt install -y unzip curl && \
    rm -rf /var/lib/apt/lists/* && \
    export VERSION=$(curl -s https://api.github.com/repos/BattleBit-Community-Servers/BattleBitAPIRunner/releases/latest | grep tag_name | cut -d '"' -f 4) && \
    curl https://github.com/BattleBit-Community-Servers/BattleBitAPIRunner/releases/download/$VERSION/$VERSION.zip -L -o $FILE  && \
    unzip -x $FILE && \
    rm $FILE && \
    mkdir -p data/dependencies data/modules data/configurations && \
    chown bbr:bbr -R /app

COPY --chown=bbr:bbr ./appsettings.json /app

USER bbr:bbr


VOLUME ["/app/data"]
EXPOSE 29294

ENTRYPOINT ["dotnet", "BattleBitAPIRunner.dll"]

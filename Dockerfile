FROM debian:buster-slim AS build-env
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /clonehero
RUN apt-get update \
 && apt-get install --no-install-recommends -y ca-certificates wget unzip curl jq libicu63 \
 && rm -rf /var/lib/apt/lists/* \
 && mkdir config

COPY ./settings.ini .

RUN wget -qO chserver.zip https://github.com/clonehero-game/releases/releases/download/V1.0.0.4080/CloneHero-standalone_server.zip \
 && unzip chserver.zip \
 && rm ./chserver.zip \
 && mv ./ChStandaloneServer-* ./chserver \
 && mv ./chserver/linux-x64 ./chserver/linux-x86_64 \
 && mv ./chserver/linux-arm64 ./chserver/linux-aarch64 \
 && mv ./chserver/linux-arm ./chserver/linux-armv7l \
 && mv ./chserver/linux-$(arch)/* . \
 && rm -rf ./chserver \
 && chmod +x ./Server \
 && chown -R 777 ./config

FROM debian:buster-slim

RUN apt-get update \
 && apt-get install --no-install-recommends -y ca-certificates libicu63 libgssapi-krb5-2 \
 && apt-get install nano \
 && rm -rf /var/lib/apt/lists/* \
 && ln -sf /usr/src/clonehero/Server /usr/bin/cloneheroserver \
 && useradd -m clonehero

WORKDIR /usr/src/clonehero
RUN chown -R 777 .
RUN chmod -R 777 .
COPY --from=build-env /clonehero .
USER clonehero

WORKDIR /usr/src/clonehero

ENV NAME="Clone Hero Docker Server"
ENV PASS="test"
ENV IP="0.0.0.0"
ENV PORT="14242"

EXPOSE 14242/udp
ENTRYPOINT ./Server -a "${IP}" -p "${PORT}" -n "${NAME}" -ps "${PASS}"

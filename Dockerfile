FROM node:8.12-alpine

COPY . /app

RUN chown -R 1001710000:1001710000 /app

WORKDIR /app

RUN apk upgrade --update \
    && apk add bash git ca-certificates \
    && npm install -g bower \
    && npm --unsafe-perm --production install \
    && apk del git \
    && rm -rf /var/cache/apk/* \
        /app/.git \
        /app/screenshots \
        /app/test

RUN chown -R 1001710000:1001710000 /app

EXPOSE 1337

VOLUME /app/kongadata

USER 1001710000

ENTRYPOINT ["/app/start.sh"]

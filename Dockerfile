FROM alpine:3.5

RUN set -ex \
  && apk update \
  && apk add jq zip \
  && apk add --no-cache --virtual .app-run-deps ca-certificates \
  && update-ca-certificates \
  && apk add --no-cache --virtual .app-builddeps curl \
  && export GDRIVE_URL='https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download' \
  && export GDRIVE_SHA128=4fd8391b300cac45963e53da44dcfe68da08d843 \
  && curl -fSL "${GDRIVE_URL}" -o /usr/local/bin/gdrive \
  && chmod +x /usr/local/bin/gdrive \
  && apk del .app-builddeps \
  && rm -rf /var/cache/apk/*

ADD entrypoint.sh /entrypoint.sh

RUN mkdir /backup && \
    chmod +x /entrypoint.sh

WORKDIR /backup

ENTRYPOINT ["/entrypoint.sh"]
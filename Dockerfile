FROM node:9.5-alpine
MAINTAINER kimgault <kimmygault@gmail.com>

ENV GITCRYPT_VERSION 0.5.0-2
ENV TZ America/Los_Angeles

# openssh needed for CircleCI
RUN apk --update add tzdata \
    jq \
    zip \
    g++ \
    git \
    make \
    curl \
    rsync \
    python \
    openssh \
    openssl-dev \
    mongodb-tools \
    && rm -rf /var/cache/apk/*

RUN cp /usr/share/zoneinfo/$TZ /etc/localtime
RUN echo $TZ >  /etc/timezone

RUN yarn global add lerna@3.16.5
RUN yarn global add serverless
RUN yarn config set workspaces-experimental true
RUN curl -L https://github.com/AGWA/git-crypt/archive/debian/$GITCRYPT_VERSION.tar.gz | tar zxv -C /var/tmp
RUN cd /var/tmp/git-crypt-debian-$GITCRYPT_VERSION && make && make install PREFIX=/usr/local

CMD ["/bin/sh"]
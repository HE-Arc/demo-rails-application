FROM ruby:2.3-alpine
MAINTAINER Yoan Blanc yoan@dosimple.ch


RUN apk update \
    && apk add --update --no-cache \
        build-base \
        curl \
        curl-dev \
        libxml2-dev \
        libxslt-dev \
        mysql-client \
        mysql-dev \
        nodejs \
        postgresql-client \
        postgresql-dev \
        sqlite \
        sqlite-dev \
        yaml \
        zlib-dev \
    && rm -rf /var/cache/apk/*


# the user
RUN adduser -h /usr/src/app -s /bin/sh -D ruby

USER ruby
RUN gem install -N bundler rails rake

USER root
COPY build/boot.sh /usr/local/bin/boot.sh
RUN chmod +x /usr/local/bin/boot.sh

EXPOSE 3000
VOLUME /usr/src

ENTRYPOINT [ "/usr/local/bin/boot.sh" ]

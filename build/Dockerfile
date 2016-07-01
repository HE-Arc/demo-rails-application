FROM ruby:2.3-alpine
MAINTAINER Yoan Blanc yoan@dosimple.ch


RUN apk update && \
    apk add --update --no-cache \
        bash \
        build-base \
        curl \
        curl-dev \
        git \
        libxml2-dev \
        libxslt-dev \
        mysql-client \
        mysql-dev \
        nano \
        nodejs \
        postgresql-client \
        postgresql-dev \
        python \
        python-dev \
        py-pip \
        sudo \
        supervisor \
        sqlite \
        sqlite-dev \
        vim \
        yaml \
        zlib-dev && \
    rm -rf /var/cache/apk/*


# the user
ENV USER ruby
RUN adduser -h /home/$USER -s /bin/bash -D $USER
RUN echo $USER:$USER | chpasswd
RUN echo $USER 'ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/$USER
RUN chmod 0440 /etc/sudoers.d/$USER

USER $USER

# Base gems
RUN sudo gem install -N bundler rails rack pry pry-doc awesome_print

# Vim propaganda
RUN git clone \
            https://github.com/VundleVim/Vundle.vim.git \
            /home/$USER/.vim/bundle/Vundle.vim
COPY build/vimrc /home/$USER/.vimrc
RUN sudo chown $USER:$USER /home/$USER/.vimrc
RUN vim +PluginInstall! +qall!

VOLUME /usr/src

USER root

COPY build/boot.sh /usr/local/bin/boot.sh
COPY build/supervisord.conf /etc/supervisord.conf
RUN chmod +x /usr/local/bin/boot.sh

EXPOSE 3000
ENTRYPOINT /usr/bin/supervisord -c /etc/supervisord.conf

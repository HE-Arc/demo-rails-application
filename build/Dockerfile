FROM rails:4.2

# NodeSource special setup (does the apt-get update already, twice)
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get dist-upgrade -q -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        python-dev \
        python-software-properties \
        sudo && \
    rm -rf /var/lib/apt/lists/*

# le Pip
RUN python -m pip version && \
    python -m pip install -U pip || \
    curl --silent --show-error --retry 5 \
        https://bootstrap.pypa.io/get-pip.py | python2.7

# supervisor
RUN pip install -U pyOpenSSL supervisor

# the user
ENV USER ruby
RUN useradd -d /home/$USER -m -s /bin/bash $USER
RUN echo $USER:$USER | chpasswd
RUN echo $USER 'ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/$USER
RUN chmod 0440 /etc/sudoers.d/$USER

# gems
RUN sudo gem install rails rack

VOLUME /usr/src

EXPOSE 3000

USER root
ADD build/boot.sh /usr/local/bin/boot.sh
ADD build/supervisord.conf /etc/supervisord.conf
RUN chmod +x /usr/local/bin/boot.sh

ENTRYPOINT /usr/local/bin/supervisord -c /etc/supervisord.conf

FROM rails:4.2

# NodeSource special setup (does the apt-get update already, twice)
RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get dist-upgrade -q -y && \
    apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        libtool-bin \
        libzmq3-dev \
        nano \
        python-dev \
        python-software-properties \
        sudo \
        vim && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# le Pip
RUN python -m pip version && \
    python -m pip install -U pip || \
    curl --silent --show-error --retry 5 \
        https://bootstrap.pypa.io/get-pip.py | python2.7

# supervisor
RUN pip install -U pyOpenSSL supervisor jupyter

# the user
ENV USER ruby
RUN useradd -d /home/$USER -m -s /bin/bash $USER
RUN echo $USER:$USER | chpasswd
RUN echo $USER 'ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/$USER
RUN chmod 0440 /etc/sudoers.d/$USER

USER $USER

# gems
RUN sudo gem install rbczmq rails rack iruby pry pry-doc awesome_print

RUN mkdir -p /home/$USER/try-ruby
ADD build/hi-ruby.ipynb /home/$USER/try-ruby/hi-ruby.ipynb
RUN sudo chown $USER:$USER /home/$USER/try-ruby/hi-ruby.ipynb

# vim plugins
RUN git clone https://github.com/VundleVim/Vundle.vim.git \
                             /home/$USER/.vim/bundle/Vundle.vim
ADD build/vimrc /home/$USER/.vimrc
RUN sudo chown $USER:$USER /home/$USER/.vimrc
RUN vim +PluginInstall! +qall!

VOLUME /usr/src

USER root

ADD build/boot.sh /usr/local/bin/boot.sh
ADD build/supervisord.conf /etc/supervisord.conf
RUN chmod +x /usr/local/bin/boot.sh

EXPOSE 3000 8888
ENTRYPOINT /usr/local/bin/supervisord -c /etc/supervisord.conf

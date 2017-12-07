# Demo Ruby on Rails application

[![Build Status](https://travis-ci.org/HE-Arc/demo-rails-application.svg?branch=master)](https://travis-ci.org/HE-Arc/demo-rails-application)
[![Docker Pulls](https://img.shields.io/docker/pulls/greut/rails.svg?maxAge=2592000?style=flat-square)](https://hub.docker.com/r/greut/rails)

How to setup a complete Rails setup on Docker.

## Requirements

So need to install the following softwares:

 * git
 * Docker
 * docker-compose

Or grab yourself the [Docker toolbox](https://www.docker.com/docker-toolbox)

## This repository

Grab it.

    $ git clone https://github.com/HE-Arc/demo-rails-application ror
    $ cd ror

## Containers

Now, the funny part that creates and starts the containers.

    # if you uncomment the docker-composer.yml
    $ docker-compose build
    # otherwise:
    $ docker build -t greut/rails -f build/Dockerfile .
    $ docker-compose up -d
    $ docker-compose logs web

## Entering the container

We will work from the container called `web`. Docker-compose puts a prefix
to it (the name of the directory) and a suffix, a counter. Hence, our web
container is identified by `ror_web_1`.

    $ docker-compose exec web /bin/sh
    / mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh
    / # su ruby
    / $ . /etc/profile
    / $ export PATH = $BUNDLE_BIN:$PATH
    $ ruby@ror:/# cd /usr/src/app
    $ ruby@ror:/usr/src/app$ rails -v
    Rails 5.1.4
    $ bundle install
    $ rails db:create db:migrate db:seed
    $ foreman start

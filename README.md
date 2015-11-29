# Demo Ruby on Rails application

How to setup a complete Rails setup on Docker.

## Requirements

So need to install the following softwares:

 * git
 * Docker
 * docker-compose

Or grab yourself the [Docker toolbox](https://www.docker.com/docker-toolbox)

## This repository

Grab it.

    $ git clone https://github.com/HE-Arc/demo-ror-application ror
    $ cd ror

## Containers

Now, the funny part that creates and starts the containers.

    $ docker-compose build
    $ docker-compose up [-d]
    $ docker-compose logs web

## Entering the container

We will work from the container called `web`. Docker-compose puts a prefix
to it (the name of the directory) and a suffix, a counter. Hence, our web
container is identified by `ror_web_1`.

    $ docker exec -it ror_web_1 /bin/bash
    # root@ror:/# su ruby
    $ ruby@ror:/# cd /usr/src/app
    $ ruby@ror:/usr/src/app$ rails -v
    Rails 4.2.5


## Setting up the rails application

    $ rails new . --database=mysql
    or for Postgresql
    $ rails new . --database=postgresql
    or for Sqlite
    $ rails new .
    There is already a .gitignore so you can press "n"

    $ rails serve --bind 0.0.0.0
    => Booting WEBrick
    => Rails 4.2.5 application starting in development on http://0.0.0.0:3000
    => Run `rails server -h` for more startup options
    => Ctrl-C to shutdown server

Then open you favorite web browser and browse the address:
[localhost:3000](http://localhost:3000).

## Fixing the database connection.

The database configuration is in the config/database.yml file. So open it and
tweak like this:

    default: &default
      adapter: mysql2
      encoding: utf8mb4
      pool: 5
      username: root
      password: <%= ENV['MYSQL_ENV_MYSQL_ROOT_PASSWORD'] %>
      host: mysql

or

    default: &default
      adapter: postgresql
      encoding: unicode
      pool: 5
      username: postgres
      password: <%= ENV['POSTGRES_ENV_POSTGRES_PASSWORD'] %>
      host: postgres

Then, you may create your database:

    $ rake db:create
    $ rails s -b 0.0.0.0

No errors anymore, epic win!

## Pushing this to my repo.

    $ git remote origin set-url origin git@github.com:me/myproject.git
    $ git add .
    $ git commit -m "My rails application"
    $ git push

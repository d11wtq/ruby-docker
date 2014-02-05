# A docker container for ruby apps

This is simply a Dockerfile for building a simple docker container that runs
ruby apps.

> Current ruby version: 2.1.0

It has ruby installed to /usr/local, and runs apps under a non-root user called
ruby. Root permissions are not needed to install gems.

Bundler and Pry are pre-installed for convenience. The container does not
contain anything else.

Some tags exist in the docker registry for other ruby versions and patch
levels.

## Usage

By default, everything runs under an unprivileged user called ruby, with the
working directory set to /home/ruby.

If you just want a bash prompt:

    docker run -t -i d11wtq/ruby bash

If you want to work in IRB (or Pry) temporarily:

    docker run -t -i d11wtq/ruby irb
    docker run -t -i d11wtq/ruby pry

If you want to load and run a rails app:

    docker run -d \
      -v ~/projects/foo:/foo \
      -p 3000:3000 \
      -w /foo \
      d11wtq/ruby \
      'bundle install && rails server'

The above command mounts your copy of ~/projects/foo to /foo in the container,
then sets the working directory to /foo and performs `rails server` to start
the app running. It also exposes the container's port 3000 to the host as port
3000.

## Advanced Usage

A more production-ready solution is to use this image as a base image for a
packaged app container. Basically install your app directly into an image and
pre-run the bundle install.

    FROM d11wtq/ruby

    ADD /path/to/ruby-project /ruby-project
    RUN cd /ruby-project; bundle install

    WORKDIR /ruby-project
    CMD rails server

Now you can build an image that already has your app installed:

    docker build -rm -t your-username/your-project .

And you can run it easily:

    docker run -name your-project -d your-username/your-project

Check the rails server logs:

    docker logs your-project

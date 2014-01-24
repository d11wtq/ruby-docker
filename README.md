# A docker container for ruby apps

This is simply a Dockerfile for building a simple docker container that runs
ruby apps.

It has chruby and ruby-build installed for version switching, but currently
only includes ruby 2.1.0.

The container does not contain anything else.

## Usage

By default, everything runs under an unprivileged user called ruby, with the
working directory set to /home/ruby.

If you just want a bash prompt:

    docker run -t -i d11wtq/ruby /bin/bash

If you want to work in IRB (or Pry) temporarily:

    docker run -t -i d11wtq/ruby ./bin/irb
    docker run -t -i d11wtq/ruby ./bin/pry

Note the path to ./bin. This is as symlink to ~/.rubies/default/bin.
~/.rubies/default is also itself a symlink to, for example, ~/.rubies/2.1.0.

Change where ~/.rubies/default points to, if you want to default to a different
version without requiring chruby to be loaded.

If you want to load and run a rails app:

    docker run -d \
      -v ~/projects/foo:/home/ruby/foo \
      -p 3000:3000 \
      -w /home/ruby/foo \
      d11wtq/ruby \
      ./bin/rails server

The above command mounts your copy of ~/projects/foo to ~/foo in the container,
then sets the working directory to ~/foo and performs `rails server` to start
the app running. It also exposes the container's port 3000 to the host as port
3000.

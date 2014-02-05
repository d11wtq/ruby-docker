# Dockerfile for a Ruby project container.
#
# This container provides an environment for running Ruby apps and nothing else.

FROM       ubuntu
MAINTAINER Chris Corbyn

RUN apt-get install -qq -y sudo git curl build-essential autoconf man
RUN apt-get install -qq -y libreadline-dev libssl-dev libxml2-dev libxslt-dev

RUN groupadd admin
RUN useradd -m -s /bin/bash -G admin ruby
RUN echo ruby:ruby | chpasswd

RUN chgrp -R admin /usr/local
RUN find /usr/local -type d | xargs chmod g+w

ADD ruby-build.tar.gz /tmp/
RUN cd /tmp/ruby-build-*; ./install.sh
RUN cd /tmp; rm -rf ruby-build-*

RUN su ruby -c "ruby-build 2.1.0 /usr/local"
RUN su ruby -c "gem install bundler pry --no-rdoc --no-ri"

ENV     HOME /home/ruby
WORKDIR /home/ruby
USER    ruby

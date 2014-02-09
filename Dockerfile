# Dockerfile for a Ruby project container.
#
# Provides an environment for running Ruby apps and nothing else.

FROM       ubuntu
MAINTAINER Chris Corbyn

RUN apt-get install -qq -y sudo git curl build-essential autoconf man
RUN apt-get install -qq -y libreadline-dev libssl-dev libxml2-dev libxslt-dev

RUN useradd -m -s /bin/bash ruby

RUN chgrp -R ruby /usr/local
RUN find /usr/local -type d | xargs chmod g+w

ADD ruby-build.tar.gz /tmp/
RUN cd /tmp/ruby-build-*; ./install.sh
RUN cd /tmp; rm -rf ruby-build-*

RUN echo "ruby ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/ruby
RUN chmod 0440 /etc/sudoers.d/ruby

ENV     HOME /home/ruby
WORKDIR /home/ruby
USER    ruby

RUN ruby-build 2.1.0 /usr/local
RUN gem install bundler pry --no-rdoc --no-ri

# Dockerfile for a Ruby project container.
#
# This container provides an environment for running Ruby apps and nothing else.

FROM       ubuntu
MAINTAINER Chris Corbyn

RUN apt-get install -qq -y sudo git curl build-essential man
RUN apt-get install -qq -y libreadline-dev libssl-dev libxml2-dev libxslt-dev

RUN groupadd admin
RUN useradd -m -s /bin/bash -G admin ruby
RUN echo ruby:ruby | chpasswd

RUN curl -sLO https://github.com/sstephenson/ruby-build/archive/v20140110.1.tar.gz
RUN tar xvzf v20140110.1.tar.gz; rm v20140110.1.tar.gz
RUN cd ruby-build-20140110.1; ./install.sh
RUN cd/; rm -rf ruby-build-20140110.1

RUN su ruby -c "mkdir ~/.rubies"
RUN su ruby -c "ruby-build 2.1.0 ~/.rubies/2.1.0"

RUN su ruby -c "ln -s ~/.rubies/2.1.0 ~/.rubies/default"
RUN su ruby -c "ln -s ~/.rubies/default/bin ~/bin"

RUN curl -sLO https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
RUN tar xvzf v0.3.8.tar.gz; rm v0.3.8.tar.gz
RUN cd chruby-0.3.8; make install
RUN cd /; rm -rf chruby-0.3.8

RUN su ruby -c 'echo "source /usr/local/share/chruby/chruby.sh" >> ~/.bashrc'
RUN su ruby -c 'echo "source /usr/local/share/chruby/auto.sh" >> ~/.bashrc'
RUN su ruby -c 'echo "chruby 2.1.0" >> ~/.bashrc'

RUN su ruby -c "~/bin/gem install bundler pry"

ENV     HOME /home/ruby
WORKDIR /home/ruby
USER    ruby

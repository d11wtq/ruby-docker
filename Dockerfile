# Dockerfile for a Ruby project container.
#
# Provides an environment for running Ruby apps and nothing else.

FROM       d11wtq/ubuntu
MAINTAINER Chris Corbyn <chris@w3style.co.uk>

ADD https://github.com/sstephenson/ruby-build/archive/v20140524.tar.gz /tmp/

RUN cd /tmp;                           \
    sudo chown default: *.tar.gz;      \
    tar xvzf *.tar.gz; rm -f *.tar.gz; \
    cd ruby-build*;                    \
    ./bin/ruby-build 2.1.2 /usr/local; \
    cd; rm -rf /tmp/ruby-build*

RUN gem install bundler pry --no-rdoc --no-ri

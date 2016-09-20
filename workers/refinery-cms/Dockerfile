FROM ubuntu:16.04
MAINTAINER Hector Fernandez

ENV REFINERY_CMS_VERSION 3-0-stable

RUN apt-get update && apt-get install -y nodejs sqlite3 libsqlite3-dev imagemagick ruby ruby-dev rubygems curl

RUN curl -sSL https://get.rvm.io | bash

RUN /usr/local/rvm/bin/rvm requirements

RUN gem install execjs
RUN gem install therubyracer
RUN gem install rails --version 4.2.6

RUN rails new refinery -m http://refinerycms.com/t/${REFINERY_CMS_VERSION}

WORKDIR refinery

ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]

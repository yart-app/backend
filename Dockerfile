FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y postgresql-client

# For postgres
RUN apt-get install -y libpq-dev

# Ffor nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# For a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install -qq -y nodejs
RUN npm install -g yarn

ENV app /usr/src/app
RUN mkdir $app
WORKDIR $app

RUN gem install bundler

# Change the bundle path to the box container
ENV BUNDLE_PATH /box

ADD . $app

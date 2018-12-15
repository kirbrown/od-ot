FROM ruby:2.5.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN adduser --disabled-password --gecos '' deploy
USER deploy
RUN mkdir /home/deploy/od-ot
WORKDIR /home/deploy/od-ot

ADD Gemfile /home/deploy/od-ot
ADD Gemfile.lock /home/deploy/od-ot

RUN bundle install

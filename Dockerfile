FROM ruby:2.5
RUN apt-get update -qq
RUN apt-get install libsqlite3-dev -y
RUN gem install bundler
WORKDIR /app
COPY . /app
RUN bundle install

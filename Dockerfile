FROM ruby:2.6.4-alpine
WORKDIR /usr/src/app
RUN apk --no-cache add build-base
COPY . .
RUN gem update --system
RUN gem install bundler -v 2.1.4
RUN bundle install

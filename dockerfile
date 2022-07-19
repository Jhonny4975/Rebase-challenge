FROM ruby:3.1.0-alpine

RUN apk add --update --no-cache \
    build-base \
    bash \
    coreutils \
    git \
    postgresql-dev \
    tzdata

WORKDIR /var/www/medical_exams

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN gem update --system && \
    gem install bundler && \
    gem cleanup

RUN bundle install

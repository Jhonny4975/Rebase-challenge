FROM ruby:3.1.0-alpine

RUN apk add --update --no-cache \
    build-base \
    bash \
    coreutils \
    git \
    postgresql-dev \
    less \
    tzdata

WORKDIR /var/www/medical_exams

RUN cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN echo "America/Sao_Paulo" >  /etc/timezone

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN gem update --system && \
    gem install bundler && \
    gem cleanup

RUN bundle install

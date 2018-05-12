
FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client nodejs 

ENV RAILS_ROOT /usr/src/app

RUN mkdir -p /var/log /var/tmp /usr/src/app /usr/src/app/tmp/cache /usr/src/app/log
RUN chgrp -R 0        /var/log /var/run /var/tmp /usr/src/app /usr/src/app /usr/src/app/tmp/cache /usr/src/app/log
RUN chmod -R g=u,a+rx /var/log /var/run /var/tmp /usr/src/app /usr/src/app /usr/src/app/tmp/cache /usr/src/app/log
RUN chmod 0664 /usr/src/app/log

WORKDIR $RAILS_ROOT
COPY . .
RUN bundle install

EXPOSE 8080
USER 1001

RUN puma -C config/puma.rb;








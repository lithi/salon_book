
FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client 

ENV RAILS_ROOT /usr/src/app

RUN mkdir -p /var/log /var/tmp /usr/src/app /usr/src/app/tmp/cache
RUN chgrp -R 0        /var/log /var/run /var/tmp /usr/src/app /usr/src/app /usr/src/app/tmp/cache
RUN chmod -R g=u,a+rx /var/log /var/run /var/tmp /usr/src/app /usr/src/app /usr/src/app/tmp/cache

WORKDIR $RAILS_ROOT
COPY . .
RUN bundle install
RUN exec bundle exec puma -C config/containers/puma.rb;

USER 1001

CMD ["rails", "server", "-b", "0.0.0.0"]






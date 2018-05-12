
FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client 

ENV RAILS_ROOT /usr/src/app

RUN mkdir -p /var/log /var/tmp /usr/src/app 
RUN chgrp -R 0        /var/log /var/run /var/tmp /usr/src/app /usr/src/app 
RUN chmod -R g=u,a+rx /var/log /var/run /var/tmp /usr/src/app /usr/src/app 

WORKDIR $RAILS_ROOT
COPY . .

RUN bundle install









FROM ruby:2.5

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/* \


    mkdir -p /var/log /var/tmp && \
    chgrp -R 0        /var/log /var/run /var/tmp /usr/src/app && \
    chmod -R g=u,a+rx /var/log /var/run /var/tmp /usr/src/app && \


WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install







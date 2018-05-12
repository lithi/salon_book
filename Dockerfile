FROM ruby:2.5

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

EXPOSE 3000
RUN \
    # Create the folders if they don't exist
    mkdir -p     /usr/src/app/tmp/cache /var/log /var/run /var/tmp && \
    chgrp -R 0   /usr/src/app/tmp/cache /var/log /var/run /var/tmp && \
    chmod -R g=u,a+rx /usr/src/app/tmp/cache /var/log /var/run /var/tmp
  # Runs image as a non-root user in every environment, so that it runs consistently on AbarCloud and your development environment.
  USER 1001

CMD ["rails", "server", "-b", "0.0.0.0"]


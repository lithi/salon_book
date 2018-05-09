# Use Alpine Linux as our base Docker image since it's only 5MB in size so
# allows us to create smaller Docker images.
FROM alpine:3.6

# Modify these variables depending on your application:
# * `TZ` Timezone for the app.
# * `RAILS_ROOT` If you are using Rails, this sets the Rails root directory.
# * `HOME` The path to the app. For Rails this is the same as `RAILS_ROOT`.
# * `DB_PACKAGES` Any database packages you use. To decrease the size of the
#    Dockerfile only install the DB packages you need.
ENV TZ=Asia/Tehran \
    RAILS_ROOT=/usr/src/app \
    HOME=$RAILS_ROOT \
    DB_PACKAGES="sqlite-dev postgresql-dev"

# Install the required packages. Find any additional packages from [the Alpine
# package explorer](https://pkgs.alpinelinux.org/packages)
RUN apk update && \
    apk add tzdata curl bash ca-certificates rsync supervisor nginx \
            build-base yarn libffi-dev libxml2-dev libxslt-dev nodejs $DB_PACKAGES \
            ruby ruby-dev ruby-bundler ruby-irb ruby-json ruby-bigdecimal ruby-nokogiri && \
    # Set the timezone based on the `TZ` variable above.
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo "${TZ}" > /etc/timezone && \
    # Set the nginx config. Nginx should be run as the default Docker image's
    # user so this has to be commented out in the config.
    sed -i "/user nginx;/c #user nginx;" /etc/nginx/nginx.conf && \
    # Setup permissions for directories and files that will be written to at runtime.
    # These need to be group-writeable for the default Docker image's user.
    # To do this, the folders are created, their group is set to the root
    # group, and the correct group permissions are added.
    mkdir -p /run/nginx /var/lib/nginx/logs && \
    chgrp -R 0        /var/log /var/run /var/tmp /run/nginx /var/lib/nginx && \
    chmod -R g=u,a+rx /var/log /var/run /var/tmp /run/nginx /var/lib/nginx && \
    # Forward the nginx logs to STDOUT and STDERR so they appear
    # in the container logs.
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    # Clean up the package cache. This reduces the size of the Docker image.
    rm -rf /var/cache/apk/*

# By default all ports are closed in the container. Here the nginx port is opened.
# Other ports that need to be opened can be added here (only ports above 1024), separated by spaces.
EXPOSE 8080
# Set the current directory for the Docker image.
WORKDIR /usr/src/app \

# Copy the required configuration files into the Docker image. Don't copy the
# application files yet as they prevent `bundle install` from being cached by
# Docker's layer caching mechanism.
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY Gemfile Gemfile.lock ./
COPY supervisord.conf /

# Run bundle install. Use system-libraries for nokogiri so it installs faster.
# Remove the nokogiri config if you're not using nokogiri.
#RUN bundle config build.nokogiri --use-system-libraries && \
#    bundle install --without test development

# Copy the application files. Initially copy them to a temp directory so their
# permissions can be updated and then copy them to the target directory. This
# reduces the size of the Docker image.
COPY . /tmp/app
RUN chgrp -R 0 /tmp/app && \
    chmod -R g=u /tmp/app && \
    cp -a /tmp/app/. . && \
    rm -rf /tmp/app && \
    chmod +x start.sh && \
    # Compile Rails assets. Remove this if you are not using Rails.
    bundle exec rake assets:precompile && \
    # Ensure Rails logs are writeable. Remove this if you are not using Rails.
    mkdir -p log && chgrp -R 0 log && chmod -R g=u log

# Specify the command to run when the container starts.
CMD ["./start.sh"]

# Specify the default user for the Docker image to run as.
USER 1001

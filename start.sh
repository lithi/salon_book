# Use the `ENTRYPOINT` DeploymentConfig environment variable to specify
# which command to run. This enables the same Dockerfile to be used for
# web and worker processes. This script contains the basics for a standard
# Rails app with sidekiq workers but it can be customized to add other
# entrypoints.
#!/usr/bin/env bash

# Prefix `bundle` with `exec` so unicorn shuts down gracefully on SIGTERM (i.e. `docker stop`)
if [ "$ENTRYPOINT" = "workers" ]
then
  echo Starting workers
  exec bundle exec sidekiq
elif [ -z "$ENTRYPOINT" ] || "$ENTRYPOINT" = "web" ]
then
  echo Starting web
  /usr/bin/supervisord -c /supervisord.conf
else
  echo Error, cannot find entrypoint $ENTRYPOINT to start
fi

# Configure puma.
workers Integer(ENV['WEB_CONCURRENCY'] || 1)
threads_count = Integer(ENV['WEB_MAX_THREADS'] || 5)
threads threads_count, threads_count
preload_app!
rackup      DefaultRackup
port        ENV['PORT'] || 3000

# Remove this if you are not using ActiveRecord.
before_fork do
  ActiveRecord::Base.connection_pool.disconnect! if defined?(ActiveRecord)
end

on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end

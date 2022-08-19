# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

workers Integer(ENV['WEB_CONCURRENCY'] || 0)
threads_count_min = Integer(ENV['MIN_THREADS'] || 5)
threads_count_max = Integer(ENV['MAX_THREADS'] || 30)
threads threads_count_min, threads_count_max

environment ENV.fetch('RAILS_ENV', 'production')

preload_app!

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

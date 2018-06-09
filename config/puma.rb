port = ENV['PORT'] || 4000
environment = ENV['RACK_ENV'] || 'development'
workers = environment == 'development' ? 1 : Integer(ENV['WEB_CONCURRENCY'] || 4)
threads_count = Integer(ENV['MAX_THREADS'] || 16)
threads = threads_count, threads_count
preload_app!

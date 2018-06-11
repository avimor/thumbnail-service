require 'dotenv'

Dotenv.load
port ENV['PORT'] || 4000
workers Integer(ENV['WEB_CONCURRENCY'] || 4) if ENV['RACK_ENV'] == 'development' 
threads_count = Integer(ENV['MAX_THREADS'] || 16)
threads threads_count, threads_count
preload_app!

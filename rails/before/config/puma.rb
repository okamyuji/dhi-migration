environment ENV.fetch("RAILS_ENV", "production")
bind "tcp://0.0.0.0:#{ENV.fetch('PORT', 8080)}"

threads_count = ENV.fetch("RAILS_MAX_THREADS", 5).to_i
threads threads_count, threads_count

workers ENV.fetch("WEB_CONCURRENCY", 0).to_i
preload_app! if ENV.fetch("WEB_CONCURRENCY", 0).to_i > 0

web: bundle exec puma -p $PORT -e $RACK_ENV -t 0:10
redis: redis-server
worker: bundle exec sidekiq -q default -q mailers

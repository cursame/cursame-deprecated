web:    bundle exec rails server thin -p $PORT 
worker: bundle exec rake jobs:work
private_pub: rackup private_pub.ru -s thin -E production

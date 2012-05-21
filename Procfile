web:    bundle exec rails server thin -p $PORT 
worker: bundle exec rake jobs:work
beanstalk: beanstalkdrails
faye:      rackup faye.ru -s thin -E production
private_pub: rackup private_pub.ru -s thin -E production
private_pub_production: rackup private_pub.ru -s thin -p $PORT -e $RACK_ENV
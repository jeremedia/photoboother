web: bundle exec rails s -b 0.0.0.0 -p 3001
socket: bundle exec puma -p 28080 cable/config.ru
file_listener: bundle exec ruby lib/listener.rb
worker: rake jobs:work

@echo off
call bundle install
call bundle exec rake db:create
call bundle exec rake db:migrate
call bundle exec rake db:seed

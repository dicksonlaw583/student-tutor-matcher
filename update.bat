@echo off
call bundle install
call rake db:migrate

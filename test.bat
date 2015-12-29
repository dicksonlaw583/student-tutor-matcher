@echo off
echo Initializing engine...
call bundle install
echo Updating schema...
call rake db:migrate
echo Setting up test environment...
call rake db:test:purge
call rake db:test:prepare
echo Starting test...
IF "%1" == "" (
	bundle exec rspec
) ELSE (
	bundle exec rspec > "%1"
)
echo Done.
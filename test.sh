#!/bin/sh
echo Initializing engine...
bundle install
echo Updating schema...
rake db:migrate
echo Setting up test environment...
rake db:test:purge
rake db:test:prepare
echo Starting test...
if ["$#" -ne 2]; then
  bundle exec rspec
else
  bundle exec rspec > $1
fi
echo Done.
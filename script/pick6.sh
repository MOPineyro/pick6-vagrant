#!/bin/sh
# Original script on https://github.com/orendon/vagrant-rails

# load rbenv and shims
# export RBENV_ROOT="${HOME}/.rbenv"
# export PATH="${RBENV_ROOT}/bin:${PATH}"
# export PATH="${RBENV_ROOT}/shims:${PATH}"

git clone https://github.com/Pick6Solutions/pick6.git
cd pick6/rails
bundle install
# rbenv rehash
# -u postgres createuser --createdb vagrant
# cp -R config/database.sample.yml config/database.yml
rake db:create
rake db:migrate
rake db:seed
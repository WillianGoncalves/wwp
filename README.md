# What We Play

## Setting up

* `\curl -sSL https://get.rvm.io | bash -s stable` - Install rvm
* `rvm install 2.4.1` - Install ruby 2.4.1
* `rvm use 2.4.1@default && gem install rails` - Install rails in ruby 2.4.1@default
* `sudo apt-get install postgresql postgresql-contrib libpq-dev`
* `sudo su - postgres`
* `create role 'role name' with superuser createdb createrole login` - See the role name with `whoami`
* `rails db:create`
* `rails db:migrate`
* `yarn install`


* annotate fabricators:
`annotate --exclude tests,fixtures,serializers`

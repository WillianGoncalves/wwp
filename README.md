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

## Run

To run the app, execute the following commands in separate consoles:
* `rails s`
* `./bin/webpack-dev-server`

## Annotate
* annotate fabricators:
`annotate --exclude tests,fixtures,serializers`

## Deploy

### Heroku

In production, you don't use the webpack server. Instead, Heroku automatically detects the **webpacker gem**,
installs the **nodejs buildpack**, runs `yarn install` for you and, when `rails assets:precompile` runs, it will also
executes `yarn run`, which will pre-compile all the assets.

So, for Heroku, you basically don't have to do anything.

### CircleCI

You must set the Heroku API Key on CircleCI settings. You also have to register CircleCI SSH Key on Heroku.

# What We Play

## Run

`docker-compose up`

Then, access:

`localhost:3000` - app

`localhost:1080` - mailcatcher

## Annotate
* annotate fabricators:
`annotate --exclude tests,fixtures,serializers`

## Test

### Rspec

```
> docker-compose exec app bash
> rspec
```

### Preview emails

| Email | URL |
|-------|-----|
|Confirmation isntructions|[http://localhost:3000/rails/mailers/devise/mailer/confirmation_instructions](http://localhost:3000/rails/mailers/devise/mailer/confirmation_instructions)|

## Deploy

### Heroku

In production, you don't use the webpack server. Instead, Heroku automatically detects the **webpacker gem**,
installs the **nodejs buildpack**, runs `yarn install` for you and, when `rails assets:precompile` runs, it will also
executes `yarn run`, which will pre-compile all the assets.

So, for Heroku, you basically don't have to do anything.

### CircleCI

You must set the Heroku API Key on CircleCI settings. You also have to register CircleCI SSH Key on Heroku.

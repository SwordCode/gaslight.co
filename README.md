# gaslight.co

[![Code Climate](https://codeclimate.com/github/gaslight/gaslight.co.png)](https://codeclimate.com/github/gaslight/gaslight.co)
[ ![Build Status](https://www.codeship.io/projects/13019560-ad1d-0131-417e-5aebfd02d0b2/status?branch=master)](https://www.codeship.io/projects/19550)

The Ruby on Rails application that powers [gaslight.co][gco].

## Setup

1. `git clone git@github.com:gaslight/gaslight.co.git`
1. `cd gaslight.co`
1. `./script/bootstrap`
1. `rails server`

## Getting Production Data

**Note:** You'll need access to the Heroku instance.

1. `script/data`

## Testing

1. `./script/ci`

## Deploy

1. You'll need access to gaslight.herokuapp.com. You can add yourself as
   a collaborator using the credentials in the accounts spreadsheet.
1. `git remote add production git@heroku.com:gaslight.git`
1. `git push production master`

Assets are pushed to S3 and deployed to CloudFront on deploy. You don't
need to do anything special.

## CI

We're using [Travis][tci].

## Issues

1. Issues are tracked using [GitHub issues][ghissues].

[gco]: http://gaslight.co
[ghissues]: https://github.com/gaslight/gaslight.co/issues
[tci]: https://travis-ci.org/gaslight/gaslight.co

## Engines

the blog and training sections of the site are built with [rails engines](http://edgeguides.rubyonrails.org/engines.html). Each engine has it's own dummy rails environment(under `spec/dummy`) used for testing each engine in isolation.

### Engine Migrations

Migrations are created within each engine using namespaced tables, so a `user` table within the training_app engine would be named `training_app_users`.

To create a migration:

```sh
cd engines/<ENGINE NAME>/
rails g migration add_some_column_to_some_table
```

Running `rake db:migrate` from within the engines directory will apply migrations to the dummy database. Running `rake db:migrate` from root directory will apply migrations (including any engine migrations) to the gaslight database.

### Engine Tests

Each engine maintains it's own test suite. The dummy environment is used when testing each engine.

To run an engines tests:

```sh
cd engines/<ENGINE NAME>/
rspec
```

To run an engine in isolation:

```sh
cd engines/<ENGINE NAME>/spec/dummy
rails s
```
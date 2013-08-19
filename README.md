# ActiveRecord::Seed

An extension of ActiveRecord that supports to dump/load data with CSV

(Won't release on rubygems.org because of my personal demand and no test)

## Installation

Add this line to your application's Gemfile. **(use `github` option)**

    gem 'activerecord-seed', github: 'itzki/activerecord-seed'

And then execute:

    $ bundle

## Usage

### Setup

* Set tables to dump/load such as master data

```ruby
# config/application.rb or config/environments/ENV.rb
config.seed.tables = %w<resources> # default: []
```

* If you want to use with all tables, set `:all`

```ruby
config.seed.tables = :all
```

* Optionally, you can set models and seed data directories

```ruby
config.seed.models_dir # default: Rails.root.join('app/models').to_s
config.seed.seeds_dir # default: Rails.root.join('db/data').to_s
```

### Dump

* Export to csv files

```sh
bundle exec rake db:seed:dump
```

### Load

* Import from csv files

```sh
bundle exec rake db:seed:load
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

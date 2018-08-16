# RequireSmasher
[![Build Status](https://travis-ci.com/jrjoacir/require-smasher.svg?branch=master)](https://travis-ci.com/jrjoacir/require-smasher)

This project was born just to solve a problem: require ruby files **recursively** in a directory. However it grew up and learned to solve other simple problems:

- require ruby files recursively in a directory and its sub-directories, trying to resolve interdependent files (`require_dir`)
- require ruby files recursively in a list of directories and their sub-directories, trying to resolve interdependent files (`require_dirs`)
- require a gem (`require_gem`)
- require a list of gems (`require_gems`)
- require a **list of gems** and ruby files in a **list of directories** and their sub-directories with just **one command** (`require_all`)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'require_smasher'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install require_smasher

## Usage

### Require All

```ruby
require_all 'directory_1', 'directory_2/sub-directory', 'gem_1', 'gem_2'
```
This command will require all ruby files found in directory `directory_1` and its sub-directories, all ruby files in directory `directory_2/sub-directory` and in its sub-directories, gem `gem_1` and gem `gem_2`.

### Require Dir

```ruby
require_dir 'directory_1'
```
This command will require all ruby files found in directory `directory_1` and in its sub-directories.

### Require Dirs

```ruby
require_dirs 'directory_1', 'directory_2/sub-directory'
```
This command accept a list of directories and it will require all ruby files found in directory `directory_1` and in its sub-directories, all ruby files in directory `directory_2/sub-directory` and in its sub-directories.

### Require Gem

```ruby
require_gem 'gem'
```
This command will require the informed gem.

### Require Gems

```ruby
require_gems 'gem_1', 'gem_2'
```
This command accept a list of gems and it will require gems `gem_1` and `gem_2`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jrjoacir/require-smasher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RequireSmasher project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/require_smasher/blob/master/CODE_OF_CONDUCT.md).

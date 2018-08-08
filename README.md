# RequireSmasher

This project was born just to solve a problem: require ruby files recursively in a directory. However it grew up and learned to solve other simple problems:

- require ruby files recursively in a directories and its sub-directories
- require ruby files recursively in a list of directories and its sub-directories
- require a gem
- require a list of gems


Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/require_smasher`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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

### Requiring everything: gems and ruby files inside a directory and its sub-directories recursively

```ruby
require_all '<DIRECTORY_NAME1>', '<DIRECTORY_NAME2/SUB-DIRECTORY>', '<GEM_NAME1>', '<GEM_NAME2>'
```
This command will require all ruby files found in directory DIRECTORY_NAME1 and its sub-directories, all ruby files in directory DIRECTORY_NAME2/SUB-DIRECTORY and its sub-directories, gem GEM_NAME1 and gem GEM_NAME2.

### Requiring ruby files inside a directory and its sub-directories recursively

```ruby
require_dir '<DIRECTORY_NAME>'
```
This command will require all ruby files found in directory DIRECTORY_NAME and its sub-directories.

### Requiring ruby files inside many directories and its sub-directories recursively

```ruby
require_dirs '<DIRECTORY_NAME1>', '<DIRECTORY_NAME2/SUB-DIRECTORY>'
```
This command will require all ruby files found in directory DIRECTORY_NAME1 and its sub-directories, all ruby files in directory DIRECTORY_NAME2/SUB-DIRECTORY and its sub-directories.

### Requiring a gem

```ruby
require_gem '<GEM_NAME>'
```
This command will require informed gem.

### Requiring many gems

```ruby
require_gems '<GEM_NAME1>', '<GEM_NAME2>'
```
This command will require gems GEM_NAME1 and GEM_NAME2.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/require_smasher. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RequireSmasher project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/require_smasher/blob/master/CODE_OF_CONDUCT.md).

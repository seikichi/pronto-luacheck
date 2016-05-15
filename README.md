# Pronto::Luacheck

[Pronto](https://github.com/mmozuras/pronto) runner for [Luacheck](https://github.com/mpeterv/luacheck).

`luacheck` is needed to be installed for this runner to work.

## Configuration

Configuring Luacheck via `.luacheckrc` will work just fine with `pronto-luacheck`.

You can explicitly specify location of Luacheck runner by passing `PRONTO_LUACHECK_PATH` env variable e.g:

```bash
PRONTO_LUACHECK_PATH=/usr/very/hidden/bin/luacheck pronto run --index
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pronto-luacheck'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pronto-luacheck

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `rake test` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`,
which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/seikichi/pronto-luacheck.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

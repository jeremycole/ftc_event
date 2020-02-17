# FtcEvent

This is a Ruby gem for accessing the SQLite3 databases produced by the FIRST Tech Challenge scorekeeper software.

This gem was primarily developed in order to access the match start times to automatically extract per-match videos excerpts from an event video. See [jeremycole/ftc_video](https://github.com/jeremycole/ftc_video) for more about that. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ftc_event'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ftc_event

## Usage

Get some basic information using IRB:

```
>> e = FtcEvent::Event.new("event.db")

>> e.name
=> "Northern Nevada FTC League Tournament"

>> e.qualifications.matches.count
=> 24

>> e.qualifications.match(1).result
=> "Red 63 points [no penalties] (win), Blue 37 points [no penalties] (loss)"
```

You'll probably want to explore with IRB.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [jeremycole/ftc_event](https://github.com/jeremycole/ftc_event).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

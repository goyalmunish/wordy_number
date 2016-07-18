# WordyNumber

Along with being a gem, WordyNumber is a command line application that reads from files specified as command-line arguments or STDIN when no files are given. Each line of the file is suppose to contain a single phone number.

For every phone number read, the gem outputs all possible word replacements from a dictionary. It tries to replace every digit of the provided phone number with a letter from a dictionary word; however, if no match can be made, a single digit will be left as is at that point. No two consecutive digits will remain unchanged and the program skips over a number (producing on output) if a match cannot be made.

All punctuations and whitespaces are ignored in both phone numbers and the dictionary file. Also, the program is not case sensitive.

Output is in capital letters with words and digits separated with a single dash (-).

For example, if the program is fed the number:

    2255.63

One possible line of output is:

    CALL-ME

According to the default dictionary.

The number encoding on the phone, the program uses is:

| Digit    | CHARACTERS |
|:---------|:-----------|
| 2        | A,B,C      |
| 3        | D,E,F      |
| 4        | G,H,I      |
| 5        | J,K,L      |
| 6        | M,N,O      |
| 7        | P,Q,R,S    |
| 8        | T,U,V      |
| 9        | W,X,Y,Z    |

WordList Sources:

http://www-01.sil.org/linguistics/wordlists/english/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wordy_number'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wordy_number

## Usage

    > sub = WordyNumber::WordyMatch.new
    > sub.display_matches num_list: [2255,225563,8587071016]

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/wordy_number. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


# RSpec Error Summary

Parses RSpec error output to provide a summary showing what errors were encountered, the number of occurrences per error, and file path and line number locations.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec_error_summary'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rspec_error_summary

## Usage

    $ rspec_error_summary [options]
    
    -p, --path [ARG]                 
    Path to the directory of spec files or individual spec file to be tested
    
    -s, --search [ARG]               
    Search for a specific string of text in the error message
    
    -v, --verbose                    
    Verbose output. Displays full error messages
    
    -h, --help                       
    Show this message

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec_error_summary/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

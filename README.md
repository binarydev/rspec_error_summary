# RSpec Error Summary

[![Gem Version](https://badge.fury.io/rb/rspec_error_summary.svg)](http://badge.fury.io/rb/rspec_error_summary)

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
    Default: "./spec/"        
    Path to the directory of spec files or individual spec file to be tested
    
    -s, --search [ARG]
    Search for a specific string of text in the error message
    
    -v, --verbose               
    Verbose output. Displays full error messages. By default, error messages are truncated to 140 characters. Any object representations ("<#Model:0x3fdddd8b036c>") in the messages are also truncated to avoid confusion when counting the number of occurrences, as these objects will have different memory addresses, despite having the same error

    e.g. "Undefined method 'test' for <#Model:0x3fdddd8b036c>" will not be considered another occurrence of the error "Undefined method 'test' for <#Model:0x2bdecb8b026a>" due to mismatching memory addresses, even though the cause of the error is the same.
    
    -h, --help                       
    Show this message

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rspec_error_summary/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

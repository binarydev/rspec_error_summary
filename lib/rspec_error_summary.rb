require "rspec_error_summary/version"
require 'rspec'
require 'colorize'

module RspecErrorSummary
  #!/usr/bin/env ruby
  class Parser

    def self.parse_spec_report(options = {})
      config = RSpec.configuration

      formatter = RSpec::Core::Formatters::JsonFormatter.new(config.output_stream)

      # create reporter with json formatter
      reporter =  RSpec::Core::Reporter.new(config)
      config.instance_variable_set(:@reporter, reporter)

      # internal hack
      # api may not be stable, works on Rspec version 3.1
      loader = config.send(:formatter_loader)
      notifications = loader.send(:notifications_for, RSpec::Core::Formatters::JsonFormatter)

      reporter.register_listener(formatter, *notifications)

      path = options[:path] || "./spec/"
      desired_failure_string = options[:search] || ""
      be_verbose = options[:verbose] || false

      puts "Running tests... This may take a few minutes..."

      RSpec::Core::Runner.run([path])

      json = formatter.output_hash


      failed_tests = json[:examples].select { |test| test[:status] == "failed" && test[:exception][:message].include?(desired_failure_string) }

      failure_messages = failed_tests.map do |test| 
        # Consume the failed tests and provide a more simplified hash with just the required info

        # Strip out the line breaks and replace standard space indents with tabs
        msg = test[:exception][:message].gsub("\n", " ").gsub("     ", "\n\t\t  ").strip
        test_split = msg.split("#<")
        
        if(test_split.count > 1 && test_split[0] != "" && !options[:verbose])
          # Indicate that there is more to the message to be seen using the verbose flag
          # or by running rspec manually on the affected files
          msg = test_split[0] + "..."
        end

        { 
          message: msg,
          file_path: test[:file_path],
          line_number: test[:line_number]
        }
        
      end

      uniq_failure_messages = failure_messages.uniq { |test| test[:message] }
      uniq_failure_messages_for_output = []
      uniq_failure_messages.map do |failed_test|
        matching_failures = failure_messages.select { |test| test[:message] == failed_test[:message] }
        files = matching_failures.map{ |test| [test[:file_path],test[:line_number]]}
        files.sort! do |a,b|
          # Sort by file path first, then line number
          comp = (a[0] <=> b[0])
          comp.zero? ? (a[1] <=> b[1]) : comp
        end

        uniq_failure_messages_for_output << { 
                                              message: failed_test[:message],
                                              count: matching_failures.count,
                                              files: files
                                            }

      end

      # Sort by number of occurrences in descending order
      uniq_failure_messages_for_output.sort!{ |a,b|  b[:count].to_i <=> a[:count].to_i }

      # Empty space between any normal RSpec output and our custom text
      puts "\n\n"
      puts "Failure message report:"
      if uniq_failure_messages_for_output.count == 0
        puts ("Either no failures in the specified tests, or the desired error you entered could not be found in the results").colorize(:green)
      else
        uniq_failure_messages_for_output.each do |failure|
          puts " "
          count_text = ("#{failure[:count]} #{ failure[:count] > 1 ? 'occurrences' : 'occurrence'}").colorize(:red)
          msg_text = ((be_verbose ? failure[:message] : failure[:message].truncate(140,separator: /\s/))).colorize(:brown)
          puts %Q~#{count_text} - #{msg_text}~
          failure[:files].each do |file|
            file_text = (file[0]).colorize(:blue)
            line_text = ("#{file[1].to_s}").colorize(:green)
            puts "\t\t#{file_text}:#{line_text}"
          end
        end
      end
      puts "\n\n"
     
    end
  end
end

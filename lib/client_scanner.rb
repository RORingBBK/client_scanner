# frozen_string_literal: true

require "debug"
require_relative "client_scanner/version"
require_relative "client_scanner/cli_config"

module ClientScanner
  class Error < StandardError; end

  # CLI is the main entry point for the client scanner application
  # which is responsible for parsing command line arguments, processing
  # options, and executing the appropriate command.
  class CLI
    def initialize(
      config = CLIConfig.new
    )
      @config = config
      @options = {}
    end

    def run(argv)
      setup_parser
      @config.parser.parse!(argv)
      process_options
    end

    private

    def setup_parser
      @config.parser.banner = "Usage: bin/client_scanner [options]"

      add_file_option
      add_search_option
      add_email_option
    end

    def add_file_option
      @config.parser.on("-f FILE", "--file FILE", "Path to the file") do |file|
        @options[:file] = file
      end
    end

    def add_search_option
      @config.parser.on("-s FIELD QUERY", "--search QUERY", "Search for a query") do |query|
        @options[:search] = query
      end
    end

    def add_email_option
      @config.parser.on("-e EMAIL", "--email EMAIL", "Search for duplicates email") do |query|
        @options[:email] = query
      end
    end

    def process_options
      file_path = @options[:file] || "data/clients.json"
      store = @config.store_class.new(file_path)

      execute_command(:search, store, @options[:search]) if @options[:search]
      execute_command(:email, store, @options[:email]) if @options[:email]

      puts @config.parser if @options.empty?
    end

    def execute_command(type, store, query)
      command = @config.commands[type].new(store, query).execute
      puts @config.presenters[type].new(command).present
    end
  end
end

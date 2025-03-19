# frozen_string_literal: true

require "optparse"
require "debug"
require_relative "client_scanner/version"
require_relative "stores/client_store"
require_relative "commands/search_command"
require_relative "commands/detect_duplicate_email_command"
require_relative "presenters/detect_duplicate_email_presenter"
require_relative "presenters/search_presenter"

module ClientScanner
  class Error < StandardError; end

  # CLI is the main entry point for the client scanner application
  # which is responsible for parsing command line arguments, processing
  # options, and executing the appropriate command.
  class CLI
    def initialize(
      parser: OptionParser.new,
      store_class: Stores::ClientStore,
      search_command: Commands::SearchCommand,
      presenter: Presenters::SearchPresenter
    )
      @parser = parser
      @store_class = store_class
      @search_command = search_command
      @presenter = presenter
      @options = {}
    end

    def run(argv)
      setup_parser
      @parser.parse!(argv)
      process_options
    end

    private

    def setup_parser
      @parser.banner = "Usage: bin/client_scanner [options]"

      add_file_option
      add_search_option
      add_email_option
    end

    def add_file_option
      @parser.on("-f FILE", "--file FILE", "Path to the file") do |file|
        @options[:file] = file
      end
    end

    def add_search_option
      @parser.on("-s FIELD QUERY", "--search QUERY", "Search for a query") do |query|
        @options[:search] = query
      end
    end

    def add_email_option
      @parser.on("-e EMAIL", "--email EMAIL", "Search for duplicates email") do |query|
        @options[:search] = query
        @search_command = Commands::DetectDuplicateEmailCommand
        @presenter = Presenters::DetectDuplicateEmailPresenter
      end
    end

    def process_options
      file_path = @options[:file] || "data/clients.json"
      store = @store_class.new(file_path)

      if @options[:search]
        execute_search(store)
      else
        puts @parser
      end
    end

    def execute_search(store)
      results = @search_command.new(store, @options[:search]).execute
      puts @presenter.new(results).present
    end
  end
end

# frozen_string_literal: true

require "optparse"
require "debug"
require_relative "client_scanner/version"
require_relative "stores/client_store"
require_relative "commands/search_command"
require_relative "presenters/search_presenter"

module ClientScanner
  class Error < StandardError; end

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

      file_path = @options[:file] || "data/clients.json"
      store = Stores::ClientStore.new(file_path)

      if @options[:search]
        results = Commands::SearchCommand.new(store, @options[:search]).execute
        puts Presenters::SearchPresenter.new(results).present
      else
        puts parser
      end
    end

    private

    def setup_parser
      @parser.banner = "Usage: bin/client_scanner [options]"

      @parser.on("-f FILE", "--file FILE", "Path to the file") do |file|
        @options[:file] = file
      end

      @parser.on("-s FIELD QUERY", "--search QUERY", "Search for a query") do |query|
        @options[:search] = query
      end
    end
  end
end

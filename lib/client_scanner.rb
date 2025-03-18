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
    def initialize
      @options = {}
    end

    def run(argv)
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: bin/client_scanner [options]"

        opts.on("-f FILE", "--file FILE", "Path to the file") do |file|
          @options[:file] = file
        end

        opts.on("-s FIELD QUERY", "--search QUERY", "Search for a query") do |query|
          @options[:search] = query
        end
      end

      parser.parse!(argv)

      file_path = @options[:file] || "data/clients.json"
      store = Stores::ClientStore.new(file_path)

      if @options[:search]
        results = Commands::SearchCommand.new(store, @options[:search]).execute
        puts Presenters::SearchPresenter.new(results).present
      else
        puts parser
      end
    end
  end
end

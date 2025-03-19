# frozen_string_literal: true

require "optparse"
require_relative "../stores/client_store"
require_relative "../commands/search_command"
require_relative "../commands/detect_duplicate_email_command"
require_relative "../presenters/detect_duplicate_email_presenter"
require_relative "../presenters/search_presenter"

module ClientScanner
  # CLIConfig is responsible for configuring the CLI application
  # by providing the necessary parser, store class, commands, and presenters.
  class CLIConfig
    def initialize
      @parser = parser
      @store_class = store_class
      @commands = commands
      @presenters = presenters
    end

    def parser
      @parser ||= OptionParser.new
    end

    def store_class
      @store_class ||= Stores::ClientStore
    end

    def commands
      @commands ||= {
        search: Commands::SearchCommand,
        email: Commands::DetectDuplicateEmailCommand
      }
    end

    def presenters
      @presenters ||= {
        search: Presenters::SearchPresenter,
        email: Presenters::DetectDuplicateEmailPresenter
      }
    end
  end
end

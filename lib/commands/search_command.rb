# frozen_string_literal: true

require_relative "base_command"

module Commands
  # SearchCommand is responsible for executing a search operation
  # on the provided store using the given query.
  class SearchCommand < BaseCommand
    def initialize(store, query)
      super(store)

      @store = store
      @query = query
    end

    def execute
      @store.search_by_name(@query)
    end
  end
end

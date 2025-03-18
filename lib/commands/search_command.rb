# frozen_string_literal: true

require_relative "base_command"

module Commands
  class SearchCommand < BaseCommand
    def initialize(store, query)
      super(store)

      @store = store
      @query = query
    end

    def execute
      @results = @store.search_by_name(@query)
    end
  end
end

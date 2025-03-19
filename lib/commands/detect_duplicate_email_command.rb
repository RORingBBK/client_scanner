# frozen_string_literal: true

module Commands
  class DetectDuplicateEmailCommand < BaseCommand
    def initialize(store, query)
      super(store)

      @store = store
      @query = query
    end

    def execute
      @store.detect_duplicate_email(@query)
    end
  end
end

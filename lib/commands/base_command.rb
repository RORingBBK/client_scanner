# frozen_string_literal: true

module Commands
  # BaseCommand serves as the abstract base class for all command classes.
  # It provides the common interface and requires subclasses to implement the `execute` method.
  class BaseCommand
    def initialize(store)
      @store = store
    end

    def execute
      raise NotImplementedError, "Subclasses must implement the execute method"
    end
  end
end

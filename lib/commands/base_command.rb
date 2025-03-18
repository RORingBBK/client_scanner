module Commands
  class BaseCommand
    def initialize(store)
      @store = store
    end

    def execute
      raise NotImplementedError, "Subclasses must implement the execute method"
    end
  end
end

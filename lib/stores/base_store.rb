module Stores
  class BaseStore
    def initialize(file_path)
      @file_path = file_path
      load_data
    end

    def load_data
      raise NotImplementedError, "Subclasses must implement the load_data method"
    end
  end
end

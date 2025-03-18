require_relative "base_store"
require "json"

module Stores
  class ClientStore < BaseStore
    def load_data
      if File.exist?(@file_path)
        file = File.read(@file_path)
        @data = JSON.parse(file, symbolize_names: true)
      else
        puts "Error: File #{@file_path} not found"
        @data = []
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
      @data = []
    end
  end
end

# frozen_string_literal: true

require "json"
require_relative "base_store"

module Stores
  # ClientStore is responsible for loading client data from the file and providing
  # search functionality based on client names
  class ClientStore < BaseStore
    def load_data
      @data = read_file(@file_path) ? parse_data(@file_path) : handle_missing_file
    rescue StandardError => e
      handle_error(e)
      @data = []
    end

    def search_by_name(query)
      @data.select { |record| record.name.to_s.downcase.include?(query.to_s.downcase) }
    end

    def detect_duplicate_email(query)
      duplicates = @data.group_by(&:email)
                        .fetch(query, [])

      duplicates.size > 1 ? duplicates : []
    end

    private

    def read_file(file_path)
      return File.read(file_path) if File.exist?(file_path)

      nil
    end

    def parse_data(file_path)
      file = File.read(file_path)
      raw_data = JSON.parse(file, symbolize_names: true)
      raw_data.map { |record| Client.new(record[:id], record[:full_name], record[:email]) }
    end

    def handle_missing_file
      puts "Error: File #{@file_path} not found"

      []
    end

    def handle_error(exception)
      puts "Error: #{exception.message}"
    end
  end
end

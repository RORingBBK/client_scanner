# frozen_string_literal: true

module Presenters
  # DetectDuplicateEmailPresenter is responsible for formatting and
  # presenting the search results in a readable format.
  class DetectDuplicateEmailPresenter
    def initialize(results)
      @results = results
    end

    def present
      return "No duplicates email found" if @results.nil? || @results&.empty?

      output = "Found #{@results.size} clients with same email\n"
      @results.each { |client| output << "- #{client[:full_name]} (#{client[:email]})\n" }

      output
    end
  end
end

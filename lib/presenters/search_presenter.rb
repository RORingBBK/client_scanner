module Presenters
  # SearchPresenter is responsible for formatting and
  # presenting the search results in a readable format.
  class SearchPresenter
    def initialize(results)
      @results = results
    end

    def present
      return "No clients found" if @results.nil? || @results&.empty?

      output = "Found #{@results.count} results:\n"
      @results.each { |client| output << "- #{client[:name]} (#{client[:email]})\n" }

      output
    end
  end
end

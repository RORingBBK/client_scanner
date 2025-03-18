# frozen_string_literal: true

RSpec.describe ClientScanner do
  let(:file_path) { "spec/fixtures/test_data.json" }
  let(:query) { "John" }
  let(:output) do
    <<~OUTPUT
      Found 1 results:
      - John Doe (john@example.com)
    OUTPUT
  end

  describe "when running the CLI with search query" do
    it "should output the search results" do
      result = `bin/client_scanner --search John --file #{file_path}`
      expect(result).to include(output)
    end
  end

  describe "when running the CLI with search query and no results" do
    it "should output no results found" do
      result = `bin/client_scanner --search Invalid --file #{file_path}`
      expect(result).to include("No clients found")
    end
  end

  describe "when file does not exist" do
    it "should output an error message" do
      result = `bin/client_scanner --search John --file invalid.json`
      expect(result).to include("Error: File invalid.json not found")
    end
  end

  describe "when options does not exist" do
    it "should prompt with usage" do
      result = `bin/client_scanner`
      expect(result).to include("Usage: bin/client_scanner [options]")
      expect(result).to include("-f, --file FILE")
      expect(result).to include("-s, --search QUERY")
    end
  end
end

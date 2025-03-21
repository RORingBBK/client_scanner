# frozen_string_literal: true

RSpec.describe ClientScanner do
  let(:query) { "John" }
  let(:output) do
    <<~OUTPUT
      Found 2 results:
      - John Doe (john.doe@gmail.com)
      - Alex Johnson (alex.johnson@hotmail.com)
    OUTPUT
  end

  describe "when running the CLI with search query" do
    it "outputs the search results" do
      result = `bin/client_scanner --search John`
      expect(result).to include(output)
    end
  end

  describe "when running the CLI with search query and no results" do
    it "outputs no results found" do
      result = `bin/client_scanner --search Invalid`
      expect(result).to include("No clients found")
    end
  end

  describe "when running the CLI with search query and email" do
    let(:output) do
      <<~OUTPUT
        Found 2 results:
        - Jane Smith (jane.smith@yahoo.com)
        - Another Jane Smith (jane.smith@yahoo.com)
        No duplicates email found
      OUTPUT
    end

    it "outputs the search results" do
      result = `bin/client_scanner --email john@example.com --search Jane`
      expect(result).to include(output)
    end
  end

  describe "when options does not exist" do
    let(:usage_output) do
      <<~USAGE
        Usage: bin/client_scanner [options]
            -s, --search QUERY               Search for a query
            -e, --email EMAIL                Search for duplicates email
      USAGE
    end

    it "prompts with usage" do
      result = `bin/client_scanner`
      expect(result).to eq(usage_output)
    end
  end
end

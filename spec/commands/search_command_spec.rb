# frozen_string_literal: true

RSpec.describe Commands::SearchCommand, type: :command do
  subject(:command) { described_class.new(store, query) }

  let(:store) { double("Store") }
  let(:query) { "John" }

  describe "#initialize" do
    it "initializes with a store and a query" do
      expect(command.instance_variable_get(:@store)).to eq(store)
      expect(command.instance_variable_get(:@query)).to eq(query)
    end
  end

  describe "#execute" do
    context "when search returns results" do
      let(:results) { [{ name: "John", email: "john@example.com" }] }

      it "calls search_by_name on the store with the query" do
        expect(store).to receive(:search_by_name).with(query).and_return(results)
        expect(command.execute).to eq(results)
      end
    end

    context "when search returns no results" do
      let(:results) { [] }

      it "calls search_by_name on the store with the query and returns empty array" do
        expect(store).to receive(:search_by_name).with(query).and_return(results)
        expect(command.execute).to eq(results)
      end
    end
  end
end

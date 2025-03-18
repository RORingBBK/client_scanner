# frozen_string_literal: true

RSpec.describe Stores::BaseStore, type: :store do
  subject(:store) { described_class.new(file_path) }

  let(:file_path) { "spec/fixtures/contacts.json" }

  describe "#load_data" do
    let(:error_message) { "Subclasses must implement the load_data method" }

    it "raises NotImplementedError" do
      expect { store.load_data }.to raise_error(NotImplementedError, error_message)
    end
  end
end

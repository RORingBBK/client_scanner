RSpec.describe Commands::BaseCommand, type: :command do
  let(:store) { double("Store") }

  subject(:command) { described_class.new(store) }

  describe "#initialize" do
    it "initialized with the store" do
      expect(command.instance_variable_get(:@store)).to eq(store)
    end
  end

  describe "#execute" do
    let(:error_message) do
      "Subclasses must implement the execute method"
    end

    it "raises NotImplementedError" do
      expect { command.execute }.to raise_error(NotImplementedError, error_message)
    end
  end
end

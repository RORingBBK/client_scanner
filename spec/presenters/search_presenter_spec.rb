# frozen_string_literal: true

RSpec.describe Presenters::SearchPresenter, type: :presenter do
  describe "#present" do
    subject { described_class.new(results).present }

    context "when results is nil" do
      let(:results) { nil }

      it { is_expected.to eq("No clients found") }
    end

    context "when results is empty" do
      let(:results) { [] }

      it { is_expected.to eq("No clients found") }
    end

    context "when results contains clients" do
      let(:results) do
        [
          Client.new(11, "John Doe", "test@hola.com"),
          Client.new(12, "Jane", "jane@hola.com")
        ]
      end
      let(:expected_output) do
        <<~OUTPUT
          Found 2 results:
          - John Doe (test@hola.com)
          - Jane (jane@hola.com)
        OUTPUT
      end

      it { is_expected.to eq(expected_output) }
    end
  end
end

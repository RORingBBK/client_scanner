# frozen_string_literal: true

RSpec.describe Presenters::DetectDuplicateEmailPresenter, type: :presenter do
  describe "#present" do
    subject { described_class.new(results).present }

    context "when results is nil" do
      let(:results) { nil }

      it { is_expected.to eq("No duplicates email found") }
    end

    context "when results is empty" do
      let(:results) { [] }

      it { is_expected.to eq("No duplicates email found") }
    end

    context "when results contains clients" do
      let(:results) do
        [
          { full_name: "John Doe", email: "test@hola.com" },
          { full_name: "Jane", email: "jane@hola.com" }
        ]
      end
      let(:expected_output) do
        <<~OUTPUT
          Found 2 clients with same email
          - John Doe (test@hola.com)
          - Jane (jane@hola.com)
        OUTPUT
      end

      it { is_expected.to eq(expected_output) }
    end
  end
end

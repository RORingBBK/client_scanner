# frozen_string_literal: true

RSpec.describe Stores::ClientStore, type: :store do
  subject(:store) { described_class.new(file_path) }

  let(:file_path) { "data/clients.json" }

  describe "#load_data" do
    context "when the file exists" do
      let(:json_data) do
        '[
          { "full_name": "John Doe", "email": "john@example.com" }
        ]'
      end

      before do
        allow(File).to receive(:exist?).and_call_original
        allow(File).to receive(:exist?).with(file_path).and_return(true)

        allow(File).to receive(:read).and_call_original
        allow(File).to receive(:read).with(file_path).and_return(json_data)
      end

      it "loads the data and parse it as JSON" do
        expect(store.instance_variable_get(:@data)).to eq([{ full_name: "John Doe", email: "john@example.com" }])
      end
    end

    context "when the file does not exist" do
      before do
        allow(File).to receive(:exist?).and_call_original
        allow(File).to receive(:exist?).with(file_path).and_return(false)
      end

      it "outputs an error message and set data to an empty array" do
        expect { store }.to output("Error: File #{file_path} not found\n").to_stdout
        expect(store.instance_variable_get(:@data)).to eq([])
      end
    end

    context "when an error occurs" do
      before do
        allow(File).to receive(:exist?).and_call_original
        allow(File).to receive(:exist?).with(file_path).and_return(true)

        allow(File).to receive(:read).and_raise(StandardError, "File read error")
      end

      it "outputs an error message and set data to an empty array" do
        expect { store }.to output("Error: File read error\n").to_stdout
        expect(store.instance_variable_get(:@data)).to eq([])
      end
    end
  end

  describe "#search_by_name" do
    subject { store.search_by_name(name) }

    let(:data) do
      [
        { full_name: "John Doe", email: "john@example.com" }
      ]
    end

    before do
      store.instance_variable_set(:@data, data)
    end

    context "when the name is found" do
      let(:name) { "John" }

      it { is_expected.to eq([{ full_name: "John Doe", email: "john@example.com" }]) }
    end

    context "when name is case insensitive" do
      let(:name) { "john" }

      it { is_expected.to eq([{ full_name: "John Doe", email: "john@example.com" }]) }
    end

    context "when the name is not found" do
      let(:name) { "Jane" }

      it { is_expected.to eq([]) }
    end
  end

  describe "#detect_duplicate_email" do
    subject { store.detect_duplicate_email(email) }

    let(:data) do
      [
        { full_name: "John Doe", email: "john@example.com" },
        { full_name: "John Second", email: "john@example.com" },
        { full_name: "John Invalid", email: "john_next@example.com" }
      ]
    end

    before do
      store.instance_variable_set(:@data, data)
    end

    context "when duplicate email is found" do
      let(:email) { "john@example.com" }

      it { is_expected.to eq([{ full_name: "John Doe", email: "john@example.com" }, { full_name: "John Second", email: "john@example.com" }]) }
    end

    context "when single email is found" do
      let(:email) { "john_next@example.com" }

      it { is_expected.to eq([]) }
    end

    context "when the email is not found" do
      let(:email) { "invalid" }

      it { is_expected.to eq([]) }
    end
  end
end

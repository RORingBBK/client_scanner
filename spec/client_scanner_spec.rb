# frozen_string_literal: true

RSpec.describe ClientScanner do
  it "has a version number" do
    expect(ClientScanner::VERSION).not_to be_nil
  end
end

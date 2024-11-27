# frozen_string_literal: true

RSpec.describe PublicStorage do
  it 'has a version number' do
    expect(PublicStorage::VERSION).not_to be_nil
  end
end

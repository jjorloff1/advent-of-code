# frozen_string_literal: true

# spec/2023/hello_world_spec.rb

require_relative '../../lib/2023/day01'

RSpec.describe Day01 do
  describe '.say_hello' do
    it 'returns the correct greeting' do
      expect(described_class.say_hello).to eq('Hello, World!')
    end
  end
end

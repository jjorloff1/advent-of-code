# spec/hello_world_spec.rb

require_relative '../lib/hello_world'

RSpec.describe HelloWorld do
  describe '.say_hello' do
    it 'returns the correct greeting' do
      expect(described_class.say_hello).to eq('Hello, World!')
    end
  end
end

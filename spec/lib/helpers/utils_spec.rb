require_relative '../../spec_helper'
require_relative '../../support/refine_string_class'

RSpec.describe RefineStringClass do
  describe 'String' do
    let(:camel) { described_class.new 'TestCamelText' }
    let(:snake) { described_class.new 'Test_Camel_Text' }

    it '.to_snake_case' do
      expect(camel.snake_case).to eq('test_camel_text')
    end

    it '.to_camel_case' do
      expect(snake.camel_case).to eq('TestCamelText')
    end
  end
end

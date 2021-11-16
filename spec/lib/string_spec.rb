require_relative '../spec_helper'

RSpec.describe 'String' do
  context '.to_snake_case' do
    it 'convert camel case string to snake case' do
      camel_case_string = 'UpdateDataOfBirth'
      expect(camel_case_string.to_snake_case).to eq('update_data_of_birth')
    end
  end

  context '.to_camel_case' do
    it 'convert snake case string to camel case' do
      snake_case_string = 'update_data_of_birth'
      expect(snake_case_string.to_camel_case).to eq('UpdateDataOfBirth')
    end
  end
end

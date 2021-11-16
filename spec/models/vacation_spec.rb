require_relative '../spec_helper'

RSpec.describe 'Vacation' do
  let(:subject) { build(:vacation, from: '2021-07-21 00:00:00 +0300', by: '2021-08-21 00:00:00 +0300') }
  it '.interval' do
    expect(subject.interval).to eq('21.07.2021 - 21.08.2021')
  end

  context 'date formate' do
    it 'format for from' do
      expect(subject.from_format).to eq('21.07.2021')
    end
    it 'format for by' do
      expect(subject.by_format).to eq('21.08.2021')
    end
  end

  context 'validate' do
    
  end
end

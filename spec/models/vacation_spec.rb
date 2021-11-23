# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Vacation' do
  let(:vacation) { build(:vacation, from: '2021-07-21 00:00:00 +0300', by: '2021-08-21 00:00:00 +0300') }

  it '.interval' do
    expect(vacation.interval).to eq('21.07.2021 - 21.08.2021')
  end

  context 'when call date formatter' do
    it { expect(vacation.from_format).to eq('21.07.2021') }
    it { expect(vacation.by_format).to eq('21.08.2021') }
  end
end

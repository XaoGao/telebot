require_relative '../../app/models/vacation'

describe 'Vacation' do
  it '.interval' do
    vacation = build(:vacation, from: '2021-07-21', by: '2021-08-21')
    expect(vacation.interval).to eq('21.07.2021 - 21.08.2021')
  end
end

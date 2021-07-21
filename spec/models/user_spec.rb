require_relative '../spec_helper'
require_relative '../../app/models/user'

describe 'User' do
  it '.full_name' do
    user = build(:user, first_name: 'Joy', last_name: 'Den')
    expect(user.full_name).to eq('Den Joy')
  end

  it '.camelize_action' do
    user = build(:user, action: 'add_date_of_birth')
    expect(user.camelize_action).to eq('AddDateOfBirth')
  end

  it '.date_of_birth_format' do
    user = build(:user, date_of_birth: '2021-07-21 00:00:00 +0300')
    expect(user.date_of_birth_format).to eq('21.07.2021')
  end

  it '#actions' do
    expect(User.actions).to eq(%i[add_date_of_birth])
  end

  it '#default_state' do
    expect(User.default_state).to eq(:empty)
  end
end

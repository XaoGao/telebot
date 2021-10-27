require_relative '../spec_helper'
require_relative '../../app/models/user'

describe 'User' do
  let(:user) { build(:user, username: 'simple_user', first_name: 'Joy', last_name: 'Den', action: 'add_date_of_birth', date_of_birth: '2021-07-21 00:00:00 +0300') }
  it '.full_name' do
    expect(user.full_name).to eq('Den Joy')
  end

  it '.camelize_action' do
    expect(user.camelize_action).to eq('AddDateOfBirth')
  end

  it '.date_of_birth_format' do
    expect(user.date_of_birth_format).to eq('21.07.2021')
  end

  it '.full_info' do
    expect(user.full_info).to eq('Den Joy simple_user 21.07.2021')
  end

  context '.in_action?' do
    it 'should return true when user have action' do
      expect(user.in_action?).to be true
    end

    it 'should return false when user have not action' do
      user = build(:user, action: nil)
      expect(user.in_action?).to be false
    end
  end

  it '#actions' do
    expect(User.actions).to eq(%i[add_date_of_birth])
  end

  it '#default_state' do
    expect(User.default_state).to eq(:empty)
  end

  it '#default_state' do
    expect(User.default_state).to eq(:empty)
  end
  
  # context '#get_or_create_from_message' do

  # end
  
end

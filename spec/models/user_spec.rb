# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'User' do
  let(:user) do
    build(:user, username: 'simple_user', first_name: 'Joy', last_name: 'Den', action: 'update_date_of_birth',
                 date_of_birth: '2021-07-21 00:00:00 +0300')
  end

  it '.full_name' do
    expect(user.full_name).to eq('Den Joy')
  end

  it '.date_of_birth_format' do
    expect(user.date_of_birth_format).to eq('21.07.2021')
  end

  describe '.full_info' do
    it 'when user have date of birth' do
      expect(user.full_info).to eq('Den Joy simple_user 21.07.2021')
    end

    it 'when user have not date of birth' do
      user.date_of_birth = nil
      expect(user.full_info).to eq('Den Joy simple_user ')
    end
  end

  describe '.in_action?' do
    it 'returns true when user have action' do
      expect(user.in_action?).to be true
    end

    it 'returns false when user have not action' do
      user = build(:user, action: nil)
      expect(user.in_action?).to be false
    end
  end

  describe 'validates' do
    context 'date of birth' do
      it 'returns error message date of birth more date now' do
        user = build(:user, date_of_birth: '3021-07-21 00:00:00 +0300')
        expect(user.valid?).to be false
        expect(user.errors[:date_of_birth]).to eq(['Дата рождения не валидная'])
      end

      it 'returns error message date of birth to less' do
        user = build(:user, date_of_birth: '1900-07-21 00:00:00 +0300')
        expect(user.valid?).to be false
        expect(user.errors[:date_of_birth]).to eq(['Дата рождения не валидная'])
      end

      it 'is valid' do
        user = build(:user, date_of_birth: '2020-07-21 00:00:00 +0300')
        expect(user.valid?).to be true
      end
    end
  end

  it '#actions' do
    expect(User.actions).to eq(%i[update_date_of_birth add_new_vacation remove_exist_vacation show_weather choose_item])
  end

  describe '#get_or_create_from_message' do
    it 'returns user when find by chat id' do
      user = create(:user, chat_id: 1)
      message = create_message(chat_id: 1)

      expect(User.get_or_create_from_message(message)).to eq(user)
    end

    it 'creates a new user' do
      message = create_message(chat_id: 2, first_name: 'Joy', last_name: 'Den', username: 'Ben')

      new_user = User.get_or_create_from_message(message)
      expect(new_user.username).to eq('Ben')
      expect(new_user.chat_id).to eq(2)
    end
  end

  describe '.vacations?' do
    it 'retruns true when have vacations' do
      user_with_vacations = create(:user)
      create_list(:vacation, 2, user: user_with_vacations)
      expect(user_with_vacations.vacations?).to be true
    end

    it 'retruns false when have not vacations' do
      expect(user.vacations?).to be false
    end
  end
end

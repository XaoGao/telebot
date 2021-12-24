# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe User do
  let(:user) do
    build(:user, username: 'simple_user', first_name: 'Joy', last_name: 'Den', action: 'update_date_of_birth',
                 date_of_birth: valid_date)
  end

  let(:date_to_mach) { '3021-07-21 00:00:00 +0300' }
  let(:valid_date) { '2021-07-21 00:00:00 +0300' }
  let(:date_to_low) { '1021-07-21 00:00:00 +0300' }

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
      user.action = nil
      expect(user.in_action?).to be false
    end
  end

  describe 'validate date of birth' do
    context 'when date of birth to mach' do
      let(:user) { build(:user, date_of_birth: date_to_mach) }

      it { expect(user.valid?).to be false }

      it {
        user.valid?
        expect(user.errors[:date_of_birth]).to eq(['Дата рождения не валидная'])
      }
    end

    context 'when date of birth to less' do
      let(:user) { build(:user, date_of_birth: date_to_low) }

      it { expect(user.valid?).to be false }

      it {
        user.valid?
        expect(user.errors[:date_of_birth]).to eq(['Дата рождения не валидная'])
      }
    end

    context 'when date of birth is valid' do
      it { expect(user.valid?).to be true }
    end
  end

  it '#actions' do
    expect(described_class.actions).to eq(%i[choose_city choose_gender set_date_of_birth update_date_of_birth
                                             add_new_vacation remove_exist_vacation show_weather create_order])
  end

  describe '#get_or_create_from_message' do
    it 'returns user when find by chat id' do
      user = create(:user, chat_id: 1)
      message = create_message(chat_id: 1)

      expect(described_class.get_or_create_from_message(message)).to eq(user)
    end

    context 'when create a new user' do
      let(:message) { create_message(chat_id: 2, first_name: 'Joy', last_name: 'Den', username: 'Ben') }
      let(:new_user) { described_class.get_or_create_from_message(message) }

      it { expect(new_user.username).to eq('Ben') }
      it { expect(new_user.chat_id).to eq(2) }
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

  describe 'check date' do
    let(:user_with_valid_date_of_birth) { build(:user, date_of_birth: valid_date) }
    let(:user_with_invalid_date_of_birth_to_low) { build(:user, date_of_birth: date_to_low) }
    let(:user_with_invalid_date_of_birth_to_math) { build(:user, date_of_birth: date_to_mach) }

    describe '.year_of_date_of_birth_to_mach?' do
      it { expect(user_with_valid_date_of_birth.send(:year_of_date_of_birth_to_mach?)).to be false }
      it { expect(user_with_invalid_date_of_birth_to_low.send(:year_of_date_of_birth_to_mach?)).to be true }
    end

    describe '.year_of_date_of_birth_negative?' do
      it { expect(user_with_valid_date_of_birth.send(:year_of_date_of_birth_negative?)).to be false }
      it { expect(user_with_invalid_date_of_birth_to_math.send(:year_of_date_of_birth_negative?)).to be true }
    end

    describe '.date_of_birth_invalid?' do
      it { expect(user_with_valid_date_of_birth.send(:date_of_birth_invalid?)).to be false }
      it { expect(user_with_invalid_date_of_birth_to_math.send(:date_of_birth_invalid?)).to be true }
    end
  end
end

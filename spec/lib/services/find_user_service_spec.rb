# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe Telebot::FindUserService do
  describe '.find' do
    subject(:find_user_service) { described_class.new }

    let!(:user_first) { create(:user, chat_id: 1) }

    context 'when come Types::Message' do
      let(:message) { create_message(chat_id: 1) }

      it 'message with chat id user' do
        allow(Telegram::Bot::Types::Message).to receive(:===).with(message).and_return(true)
        user = find_user_service.find(message)
        expect(user).to eq(user_first)
      end
    end

    context 'when come Types::CallbackQuery' do
      let(:message) { create_callback(id: 1) }

      it 'message with chat id user' do
        allow(Telegram::Bot::Types::CallbackQuery).to receive(:===).with(message).and_return(true)
        user = find_user_service.find(message)
        expect(user).to eq(user_first)
      end
    end

    context 'when come wrong message' do
      it 'argument error' do
        expect { find_user_service.find('wrong message') }.to raise_error(ArgumentError)
      end
    end
  end
end

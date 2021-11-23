# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe 'FindUserService' do
  describe '.find' do
    let(:user_first) { create(:user, chat_id: 1) }
    let(:user_second) { create(:user, chat_id: 2) }
    let(:user_last) { create(:user, chat_id: 3) }

    # context 'when come Types::Message' do
    #   it 'message with chat id user' do
    #     message = create_message(chat_id: 1)
    #     user = FindUserService.new.find(message)
    #     expect(user).to be user_first
    #   end
    # end

    # context 'when come Types::CallbackQuery' do
    #   it 'message with chat id user' do
    #     x = FindUserService.new.find(nil)
    #     expect(true).to be true
    #   end
    # end
  end
end

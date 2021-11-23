# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'CommandBase' do
  let(:bot) { 'fake_bot' }
  let(:message) { create_message(chat_id: 1, text: '/dump') }
  let(:user) { create(:user) }

  let(:subject) { Command.new(bot, message, user) }

  describe 'initialize' do
    it { expect(subject.instance_variable_get(:@bot)).to eq(bot) }
    it { expect(subject.instance_variable_get(:@message)).to eq(message) }
    it { expect(subject.instance_variable_get(:@user)).to eq(user) }
  end
end

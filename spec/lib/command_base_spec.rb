# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Telebot::CommandBase do
  let(:bot) { 'fake_bot' }
  let(:message) { create_message(chat_id: 1, text: '/dump') }
  let(:user) { create(:user, action: 'update_date_of_birth') }

  let(:subject) { described_class.new(bot, message, user) }

  describe '.initialize' do
    it { expect(subject.instance_variable_get(:@bot)).to eq(bot) }
    it { expect(subject.instance_variable_get(:@message)).to eq(message) }
    it { expect(subject.instance_variable_get(:@user)).to eq(user) }
  end

  describe '.command_done' do
    it 'change status user to empty and save' do
      subject.send(:command_done)
      expect(User.find(id: user.id).action).to eq(User.aasm(:actions).initial_state.to_s)
    end
  end

  describe 'call back methods' do
    it 'check methods exist' do
      described_class::CALL_BACKS.each do |method_name|
        expect(described_class.methods.include?(method_name.to_sym)).to be true
      end
    end
  end

  describe '.call' do
    it { expect(subject.call).to be nil }
  end
end

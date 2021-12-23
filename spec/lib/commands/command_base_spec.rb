# frozen_string_literal: true

require_relative '../../spec_helper'

RSpec.describe Telebot::CommandBase do
  subject(:command_base) { described_class.new(bot, message, user) }

  let(:bot) { 'fake_bot' }
  let(:message) { create_message(chat_id: 1, text: '/dump') }
  let(:user) { create(:user, action: 'update_date_of_birth') }

  describe '.initialize' do
    it { expect(command_base.instance_variable_get(:@bot)).to eq(bot) }
    it { expect(command_base.instance_variable_get(:@message)).to eq(message) }
    it { expect(command_base.instance_variable_get(:@user)).to eq(user) }
  end

  describe 'call back' do
    it 'check methods exist' do
      described_class::CALL_BACKS.each do |method_name|
        expect(described_class).to respond_to(method_name.to_sym).with(1).arguments
      end
    end

    it 'check fileds exist' do
      described_class::CALL_BACKS.each do |method_name|
        expect(described_class).to respond_to("#{method_name}_step".to_sym).with(0).arguments
      end
    end
  end

  describe '.call' do
    it { expect(command_base.call).to be nil }
  end
end

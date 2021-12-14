# frozen_string_literal: true

require_relative '../../spec_helper'
require 'yaml'

RSpec.describe Telebot::CommandFactory do
  subject(:command_factory) { described_class.new(bot, routes) }

  let(:message_is_command) { create_message(text: '/dump') }
  let(:message_simple_text) { create_message(text: 'not_command') }
  let(:routes) { YAML.safe_load(File.read(File.join(File.dirname(__FILE__), '..', '..', 'support', 'test_routes.yml'))) }
  let(:user) { create(:user, action: 'dump') }
  let(:bot) { 'Fake_bot' }

  describe '.initialize' do
    subject(:command_factory) { described_class.new('Fake_bot', 'Fake_routes') }

    it { expect(command_factory.instance_variable_get(:@bot)).to eq('Fake_bot') }
    it { expect(command_factory.instance_variable_get(:@routes)).to eq('Fake_routes') }
  end

  describe '.command' do
    it 'retrun a command class' do
      expect(command_factory.send(:command, user, message_is_command, routes)).to be_an_instance_of(DumpCommand)
    end
  end

  describe '.action' do
    it 'retrun a action class' do
      expect(command_factory.send(:action, user, message_simple_text)).to be_an_instance_of(DumpAction)
    end
  end

  describe '.create_command' do
    it 'when message is command name' do
      expect(command_factory.create_command(user, message_is_command)).to be_an_instance_of(DumpCommand)
    end

    it 'when user in action and message is not command name' do
      allow(user).to receive(:in_action?).and_return(true)
      command_factory = described_class.new(bot, routes)
      expect(command_factory.create_command(user, message_simple_text)).to be_an_instance_of(DumpAction)
    end

    it 'when user is not in action and message is not command name' do
      allow(user).to receive(:in_action?).and_return(false)
      command_factory = described_class.new(bot, routes)
      expect(command_factory.create_command(user, message_simple_text)).to be_an_instance_of(Telebot::NilCommand)
    end
  end
end

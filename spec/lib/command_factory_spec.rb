# frozen_string_literal: true

require_relative '../spec_helper'
require 'yaml'

RSpec.describe 'CommandFactory' do
  let(:message_is_command) { create_message(text: '/dump') }
  let(:message_simple_text) { create_message(text: 'not_command') }
  let(:routes) { YAML.safe_load(File.read(File.join(File.dirname(__FILE__), '..', 'support', 'test_routes.yml'))) }
  let(:user) { create(:user, action: 'dump') }
  let(:bot) { 'Fake_bot' }
  let(:subject) { CommandFactory.new(bot, message_is_command, user) }

  describe '.initialize' do
    let(:subject) { CommandFactory.new('Fake_bot', 'Fake_message', 'Fake_user') }

    it { expect(subject.instance_variable_get(:@bot)).to eq('Fake_bot') }
    it { expect(subject.instance_variable_get(:@message)).to eq('Fake_message') }
    it { expect(subject.instance_variable_get(:@user)).to eq('Fake_user') }
  end

  describe '.command' do
    it 'retrun a command class' do
      expect(subject.send(:command, routes)).to be_an_instance_of(DumpCommand)
    end
  end

  describe '.action' do
    it 'retrun a action class' do
      expect(subject.send(:action)).to be_an_instance_of(DumpAction)
    end
  end

  describe '.create_command' do
    it 'when message is command name' do
      expect(subject.create_command(routes)).to be_an_instance_of(DumpCommand)
    end

    it 'when user in action and message is not command name' do
      allow(user).to receive(:in_action?).and_return(true)
      subject = CommandFactory.new(bot, message_simple_text, user)
      expect(subject.create_command(routes)).to be_an_instance_of(DumpAction)
    end

    it 'when user is not in action and message is not command name' do
      allow(user).to receive(:in_action?).and_return(false)
      subject = CommandFactory.new(bot, message_simple_text, user)
      expect(subject.create_command(routes)).to be_an_instance_of(NilCommand)
    end
  end
end

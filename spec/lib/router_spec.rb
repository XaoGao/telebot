# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Telebot::Router do
  describe '.initialize' do
    subject(:router) { described_class.new('Fake_bot', 'Fake_routes') }

    it { expect(router.instance_variable_get(:@command_factory)).to be_an_instance_of(Telebot::CommandFactory) }
    it { expect(router.instance_variable_get(:@find_user_service)).to be_an_instance_of(Telebot::FindUserService) }
  end

  describe '.resolve' do
    subject(:router) { described_class.new('Fake_bot', routes) }

    let(:routes) do
      YAML.safe_load(File.read(File.join(File.dirname(__FILE__), '..', 'support', 'test_routes.yml')))
    end
    let(:user) { create(:user, chat_id: 1) }
    let(:find_user_service) { instance_double(Telebot::FindUserService, find: user) }
    let(:command_factory) { instance_double(Telebot::CommandFactory, create_command: nil_command) }
    let(:nil_command) { Telebot::NilCommand.new(nil, nil, nil) }
    let(:message) { create_message chat_id: 1, text: 'simple text' }

    context 'when message is plain text' do
      it 'success call nil command' do
        router.instance_variable_set(:@find_user_service, find_user_service)
        router.instance_variable_set(:@command_factory, command_factory)
        expect(router.resolve(message)).to eq(nil)
      end
    end

    context 'when raise error' do
      it 'log error and return nil' do
        allow(command_factory).to receive(:create_command).and_raise(ArgumentError, 'test error')
        router.instance_variable_set(:@find_user_service, find_user_service)
        router.instance_variable_set(:@command_factory, command_factory)
        expect(router.resolve(message)).to eq(nil)
      end
    end
  end
end

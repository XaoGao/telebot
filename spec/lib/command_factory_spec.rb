# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'CommandFactory' do
  describe '.initialize' do
    let(:subject) { CommandFactory.new('Fake_bot', 'Fake_message', 'Fake_user') }

    it 'sets a bot' do
      expect(subject.instance_variable_get(:@bot)).to eq('Fake_bot')
    end

    it 'sets a message' do
      expect(subject.instance_variable_get(:@message)).to eq('Fake_message')
    end

    it 'sets a user' do
      expect(subject.instance_variable_get(:@user)).to eq('Fake_user')
    end
  end

  # context '.create_command' do
  #   let(:user) { create(:user) }
  #   let(:message) { create_message(chat_id: 1, text: '/dump') }
  #   let(:bot) { 'fake_bot' }
  #   let(:subject) { CommandFactory.new(bot, message, user) }

  #   it 'should return nil command' do
  #     subject = CommandFactory.new('Fake_bot', message, user)
  #     command = subject.create_command({})
  #     expect(command.class.to_s).to eq('NilCommand')
  #   end
  # end

  # describe 'private methods' do
  #   let(:user) { create(:user) }
  #   let(:message) { create_message(chat_id: 1) }
  #   let(:subject) { CommandFactory.new('Fake_bot', message, user) }
  #   context '.command' do
  #     let(:routes) { read_routes }
  #     let(:message) { create_message(chat_id: 1, text: '/dump') }

  #     it 'should return a new instance dump command class' do
  #       command = subject.send(:command, routes)
  #       expect(command.class.to_s).to eq('DumpCommand')
  #     end
  #   end

  #   context '.action' do
  #     let(:user) { create(:user, action: 'dump') }

  #     it 'should return a new instance dump action class' do
  #       command = subject.send(:action)
  #       expect(command.class.to_s).to eq('DumpAction')
  #     end
  #   end
  # end
end

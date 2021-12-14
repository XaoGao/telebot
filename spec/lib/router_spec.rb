# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Telebot::Router do
  describe '.initialize' do
    subject(:router) { described_class.new('Fake_bot', 'Fake_routes') }

    it { expect(router.instance_variable_get(:@command_factory)).to be_an_instance_of(Telebot::CommandFactory) }
  end
  # describe '.resolve' do
  # end
end

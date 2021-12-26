# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Item do
  let(:item) { build(:item, image: 'test.jpg') }

  describe '.path_to_image' do
    it 'return full path ot image' do
      allow(TelegramBot::Application).to receive(:root).and_return('/')
      expect(item.path_to_image).to eq('/app/assets/images/test.jpg')
    end
  end

  describe '.info' do
    let(:item) { build(:item, name: 'raf', desc: 'good coffee') }

    it 'retrun name and desc' do
      expect(item.info).to eq('raf: good coffee')
    end
  end

  describe '.price_info' do
    let(:item) { build(:item, price: 33.2) }

    it 'retrun name and desc' do
      expect(item.price_info).to eq('Купить 33.2 рублей')
    end
  end
end

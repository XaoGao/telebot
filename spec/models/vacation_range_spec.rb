require_relative '../spec_helper'

RSpec.describe 'VacationRange' do
  let(:range) { VacationRange.new('2021-07-21 00:00:00 +0300', '2021-08-21 00:00:00 +0300') }

  context 'success create' do
    it { expect(range.class.to_s).to eq('VacationRange') }
  end

  context 'should raise error when from > by' do
    it { expect { VacationRange.new('2022-07-21 00:00:00 +0300', '2021-08-21 00:00:00 +0300') }.to raise_error(ArgumentError) }
  end

  describe 'private methods' do
    context '.parse_date' do
      let(:date_time) { DateTime.parse '2021-07-21 00:00:00 +0300' }
      it 'success parse date' do
        expect(range.send(:parse_date, :from, '2021-07-21 00:00:00 +0300')).to eq(date_time)
      end

      it 'should rise error when date is nil' do
        expect { range.send(:parse_date, :from, nil) }.to raise_error(ArgumentError)
      end

      it 'should rise error when date is empty' do
        expect { range.send(:parse_date, :from, '') }.to raise_error(ArgumentError)
      end
    end
  end
end

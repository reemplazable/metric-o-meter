# frozen_string_literal: true

# == Schema Information
#
# Table name: measures
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  timestamp  :datetime         not null
#  value      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_measures_on_name_and_timestamp  (name,timestamp)
#  index_measures_on_value               (value)
#
require 'rails_helper'

RSpec.describe Measure, type: :model do
  describe 'validations' do
    subject(:valid_measure) { measure.valid? }

    context 'with all the fields' do
      let(:measure) { build(:measure) }

      it 'is valid' do
        expect(valid_measure).to eq true
      end
    end

    context 'with no timestamp' do
      let(:measure) { build(:measure, timestamp: nil) }

      it 'is invalid' do
        expect(valid_measure).to eq false
      end
    end

    context 'with no name' do
      let(:measure) { build(:measure, name: nil) }

      it 'is invalid' do
        expect(valid_measure).to eq false
      end
    end

    context 'with no value' do
      let(:measure) { build(:measure, value: nil) }

      it 'is invalid' do
        expect(valid_measure).to eq false
      end
    end
  end

  describe '.between' do
    subject(:measures_in_between) { Measure.between(start_date, end_date) }

    let(:measure) { create(:measure) }
    context 'with a measure in between dates' do
      let(:start_date) { measure.timestamp - 1.hour }
      let(:end_date) { measure.timestamp + 1.hour }

      it 'returns the measure' do
        expect(measures_in_between).to eq [measure]
      end
    end

    context 'with a measure out of date range' do
      let(:start_date) { measure.timestamp - 2.hours }
      let(:end_date) { measure.timestamp - 1.hour }

      it 'returns nothing' do
        expect(measures_in_between).to eq []
      end
    end
  end

  describe '.named' do
    subject(:named_measure) { Measure.named(name) }

    let(:measure) { create(:measure) }
    context 'with the actual name' do
      let(:name) { measure.name }

      it 'finds the measure' do
        expect(named_measure).to eq [measure]
      end
    end

    context 'with a bogus name' do
      let(:name) { 'bogus' }

      it 'returns nothing' do
        expect(named_measure).to eq []
      end
    end
  end

  describe '.avg_value' do
    subject(:avg_value) { Measure.avg_value }
    let!(:measure_a) { create(:measure, value: 2) }
    let!(:measure_b) { create(:measure, value: 4) }

    it 'calculates the average' do
      expect(avg_value).to eq 3
    end
  end
end

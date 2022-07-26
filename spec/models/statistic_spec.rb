# frozen_string_literal: true

# == Schema Information
#
# Table name: statistics
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  stat_type  :integer          not null
#  timestamp  :datetime         not null
#  value      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_statistics_on_name_and_timestamp_and_stat_type  (name,timestamp,stat_type) UNIQUE
#  index_statistics_on_value                             (value)
#
require 'rails_helper'

RSpec.describe Statistic, type: :model do
  describe 'validations' do
    subject(:valid_statistic) { statistic.valid? }

    context 'with all the fields' do
      let(:statistic) { build(:statistic) }

      it 'is valid' do
        expect(valid_statistic).to eq true
      end
    end

    context 'with no timestamp' do
      let(:statistic) { build(:statistic, timestamp: nil) }

      it 'is invalid' do
        expect(valid_statistic).to eq false
      end
    end

    context 'with no stat_type' do
      let(:statistic) { build(:statistic, stat_type: nil) }

      it 'is invalid' do
        expect(valid_statistic).to eq false
      end
    end

    context 'with no name' do
      let(:statistic) { build(:statistic, name: nil) }

      it 'is invalid' do
        expect(valid_statistic).to eq false
      end
    end

    context 'with no value' do
      let(:statistic) { build(:statistic, value: nil) }

      it 'is invalid' do
        expect(valid_statistic).to eq false
      end
    end
  end

  describe '.named' do
    subject(:named_statistic) { Statistic.named(name) }

    let(:statistic) { create(:statistic) }
    context 'with the actual name' do
      let(:name) { statistic.name }

      it 'finds the statistic' do
        expect(named_statistic).to eq [statistic]
      end
    end

    context 'with a bogus name' do
      let(:name) { 'bogus' }

      it 'returns nothing' do
        expect(named_statistic).to eq []
      end
    end
  end

  describe '.time_ordered' do
    subject(:time_ordered_statistics) { Statistic.time_ordered }

    let(:timestamp) { DateTime.now }
    let!(:new_statistic) { create(:statistic, timestamp:) }
    let!(:old_statistic) { create(:statistic, timestamp: timestamp - 1.minute) }

    it 'returns time ordered statistics' do
      expect(time_ordered_statistics).to eq [old_statistic, new_statistic]
    end
  end

  describe '#timestamp_msec' do
    let(:statistic) { create(:statistic) }

    it 'returns timestamp in miliseconds' do
      expect(statistic.timestamp_msec).to eq statistic.timestamp.to_i * 1000
    end
  end
end

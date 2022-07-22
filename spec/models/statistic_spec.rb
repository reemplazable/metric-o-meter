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
end

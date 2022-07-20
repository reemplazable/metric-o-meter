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
end

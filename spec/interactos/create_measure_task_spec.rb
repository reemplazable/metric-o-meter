# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMeasureTask do
  subject(:create_measure) { described_class.execute(context) }

  let(:context) { ActionLogic::ActionContext.new(measure_params:) }

  describe 'validations' do
    context 'with empty context' do
      let(:context) { ActionLogic::ActionContext.new }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::MissingAttributeError)
      end
    end

    context 'with empty params' do
      let(:measure_params) { nil }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::PresenceError)
      end
    end

    context 'with empty params' do
      let(:measure_params) { {} }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::PresenceError)
      end
    end

    context 'with no name' do
      let(:measure_params) { attributes_for(:measure).except(:name) }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::PresenceError)
      end
    end

    context 'with no value' do
      let(:measure_params) { attributes_for(:measure).except(:value) }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::PresenceError)
      end
    end

    context 'with no timestamp' do
      let(:measure_params) { attributes_for(:measure).except(:timestamp) }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::PresenceError)
      end
    end
  end

  describe '.execute' do
    let(:measure_params) { attributes_for(:measure) }

    it 'creates a new measure' do
      expect(Measure.find_by(measure_params)).to be nil
      create_measure
      expect(Measure.find_by(measure_params)).to be
    end
  end
end

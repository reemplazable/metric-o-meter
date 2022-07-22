# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewMeasureUseCase do
  describe '.execute' do
    subject(:new_measure) { NewMeasureUseCase.execute(measure_params: measure_parameters) }

    let(:measure_parameters) { attributes_for(:measure) }
    context 'with a new measure' do
      it 'creates the measure' do
        expect { new_measure }.to change { Measure.count }.by(1)
      end

      it 'creates avg per second statistic' do
        new_measure
        timestamp = DateTime.parse(measure_parameters[:timestamp]).change(nsec: 0)
        expect(Statistic.find_by(name: measure_parameters[:name], timestamp:,
                                 stat_type: :avg_per_second)).to be
      end

      it 'creates avg per minute statistic' do
        new_measure
        timestamp = DateTime.parse(measure_parameters[:timestamp]).beginning_of_minute
        expect(Statistic.find_by(name: measure_parameters[:name], timestamp:,
                                 stat_type: :avg_per_minute)).to be
      end

      it 'creates avg per hour statistic' do
        new_measure
        timestamp = DateTime.parse(measure_parameters[:timestamp]).beginning_of_hour
        expect(Statistic.find_by(name: measure_parameters[:name], timestamp:,
                                 stat_type: :avg_per_hour)).to be
      end
    end
  end
end

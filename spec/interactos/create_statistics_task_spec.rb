# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateStatisticsTask do
  subject(:create_measure) { described_class.execute(context) }

  let(:context) { ActionLogic::ActionContext.new(measure:) }

  describe 'validations' do
    context 'with empty context' do
      let(:context) { ActionLogic::ActionContext.new }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::MissingAttributeError)
      end
    end

    context 'with no measure' do
      let(:measure) { nil }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::AttributeTypeError)
      end
    end

    context 'with not persisted measure' do
      let(:measure) { build(:measure) }

      it 'throws exception' do
        expect { create_measure }.to raise_error(ActionLogic::PresenceError)
      end
    end
  end

  describe '.execute' do
    context 'with two measure in the same nanosecond timestamp' do
      let(:measure) { create(:measure, value: 2) }
      let(:another_measure) { create(:measure, value: 4) }

      it 'creates statistics for the new measure' do
        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                                 stat_type: :avg_per_second)).to be nil
        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                                 stat_type: :avg_per_minute)).to be nil
        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                                 stat_type: :avg_per_hour)).to be nil

        create_measure

        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                                 stat_type: :avg_per_second)).to be
        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                                 stat_type: :avg_per_minute)).to be
        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                                 stat_type: :avg_per_hour)).to be
      end

      it 'updates the averages' do
        create_measure
        described_class.execute(ActionLogic::ActionContext.new(measure: another_measure))

        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                                 stat_type: :avg_per_second).value.to_i).to eq 3
        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                                 stat_type: :avg_per_minute).value.to_i).to eq 3
        expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                                 stat_type: :avg_per_hour).value.to_i).to eq 3
      end
    end
  end

  context 'with two measure in the same minute timestamp' do
    let(:measure) { create(:measure, value: 2) }
    let(:another_measure) { create(:measure, value: 4, timestamp: (measure.timestamp - 2.seconds)) }

    it 'creates statistics for the new measure' do
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                               stat_type: :avg_per_second)).to be nil
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                               stat_type: :avg_per_minute)).to be nil
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                               stat_type: :avg_per_hour)).to be nil

      create_measure

      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                               stat_type: :avg_per_second)).to be
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                               stat_type: :avg_per_minute)).to be
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                               stat_type: :avg_per_hour)).to be
    end

    it 'updates the averages' do
      create_measure
      described_class.execute(ActionLogic::ActionContext.new(measure: another_measure))

      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                               stat_type: :avg_per_second).value.to_i).to eq 2
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                               stat_type: :avg_per_minute).value.to_i).to eq 3
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                               stat_type: :avg_per_hour).value.to_i).to eq 3
    end
  end

  context 'with two measure in the same hour timestamp' do
    let(:measure) { create(:measure, value: 2) }
    let(:another_measure) { create(:measure, value: 4, timestamp: (measure.timestamp - 2.minutes)) }

    it 'creates statistics for the new measure' do
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                               stat_type: :avg_per_second)).to be nil
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                               stat_type: :avg_per_minute)).to be nil
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                               stat_type: :avg_per_hour)).to be nil

      create_measure

      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                               stat_type: :avg_per_second)).to be
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                               stat_type: :avg_per_minute)).to be
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                               stat_type: :avg_per_hour)).to be
    end

    it 'updates the averages' do
      create_measure
      described_class.execute(ActionLogic::ActionContext.new(measure: another_measure))

      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.change(nsec: 0),
                               stat_type: :avg_per_second).value.to_i).to eq 2
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_minute,
                               stat_type: :avg_per_minute).value.to_i).to eq 2
      expect(Statistic.find_by(name: measure.name, timestamp: measure.timestamp.beginning_of_hour,
                               stat_type: :avg_per_hour).value.to_i).to eq 3
    end
  end
end

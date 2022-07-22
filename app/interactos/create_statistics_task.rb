# frozen_string_literal: true

class CreateStatisticsTask
  include ActionLogic::ActionTask

  validates_before measure: { type: Measure, presence: ->(measure) { persisted_measure(measure) } }

  def call
    Statistic.stat_types.each_key do |statistic|
      case statistic.to_sym
      when :avg_per_second
        create_avg_per_second
      when :avg_per_minute
        create_avg_per_minute
      when :avg_per_hour
        create_avg_per_hour
      end
    end
  end

  def self.persisted_measure(measure)
    measure&.persisted?
  end

  private

  def create_avg_per_second
    start_date = timestamp.change(nsec: 0)
    average = avg_between(measure.name, start_date, measure.timestamp.change(nsec: 999_999_999))
    create_or_update_statistic(start_date, :avg_per_second, average)
  end

  def create_avg_per_minute
    start_date = timestamp.beginning_of_minute
    average = avg_between(name, start_date, timestamp.end_of_minute)
    create_or_update_statistic(start_date, :avg_per_minute, average)
  end

  def create_avg_per_hour
    start_date = timestamp.beginning_of_hour
    average = avg_between(name, start_date, timestamp.end_of_hour)
    create_or_update_statistic(start_date, :avg_per_hour, average)
  end

  def create_or_update_statistic(timestamp, stat_type, value)
    Statistic.find_or_create_by(name:, timestamp:, stat_type:).tap do |statistic|
      statistic.value = value
      statistic.save!
    end
  end

  def avg_between(name, start_date, end_date)
    Measure.by_name(name).between(start_date, end_date).average(:value)
  end

  def measure
    context.measure
  end

  def name
    measure.name
  end

  def timestamp
    measure.timestamp
  end
end

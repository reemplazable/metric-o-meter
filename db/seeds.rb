# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def avg_between(name, start_date, end_date)
  Measure.by_name(name).between(start_date, end_date).average(:value)
end

# create random measures every in a 100 ticks
# do it for 3 measures
['Living room', 'Kitchen', 'Bedroom'].each do |room_name|
  end_date = DateTime.now.strftime('%Q').to_i
  start_date = (DateTime.now - 5.hours).strftime('%Q').to_i
  measures = (1..end_date - start_date).map do |t|
    { name: room_name, value: rand(0..50), timestamp: Time.strptime((start_date + t).to_s, '%Q') } if rand(0..999) == 1
  end.compact
  Measure.insert_all(measures)

  # Statistics
  statistics_by_second = Measure.select(:timestamp, :name).group('strftime("%Y%m%d%H%M%S", timestamp)').map do |m|
    start_date = m.timestamp.change(nsec: 0)
    average = avg_between(m.name, start_date, m.timestamp.change(nsec: 999_999_999))
    { name: m.name, timestamp: start_date, stat_type: 0, value: average }
  end

  statistics_by_minute = Measure.select(:timestamp, :name).group('strftime("%Y%m%d%H%M", timestamp)').map do |m|
    start_date = m.timestamp.beginning_of_minute
    average = avg_between(m.name, start_date, m.timestamp.end_of_minute)
    { name: m.name, timestamp: start_date, stat_type: 1, value: average }
  end

  statistics_by_hour = Measure.select(:timestamp, :name).group('strftime("%Y%m%d%H", timestamp)').map do |m|
    start_date = m.timestamp.beginning_of_hour
    average = avg_between(m.name, start_date, m.timestamp.end_of_hour)
    { name: m.name, timestamp: start_date, stat_type: 2, value: average }
  end

  Statistic.upsert_all(statistics_by_second, unique_by: %i[name timestamp stat_type])
  Statistic.upsert_all(statistics_by_minute, unique_by: %i[name timestamp stat_type])
  Statistic.upsert_all(statistics_by_hour, unique_by: %i[name timestamp stat_type])
end

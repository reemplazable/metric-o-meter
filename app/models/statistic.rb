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
class Statistic < ApplicationRecord
  enum stat_type: { avg_per_second: 0, avg_per_minute: 1, avg_per_hour: 2 }
  validates :name, :timestamp, :stat_type, :value, presence: true
  scope :named, ->(name) { where(name:) }
  scope :time_ordered, -> { order(:timestamp) }

  def timestamp_msec
    timestamp.to_i * 1000
  end
end

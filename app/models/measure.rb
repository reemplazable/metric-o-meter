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
class Measure < ApplicationRecord
  validates :name, :timestamp, :value, presence: true

  scope :between, ->(start_date, end_date) { where(timestamp: start_date..end_date) }
  scope :named, ->(name) { where(name:) }
  scope :avg_value, -> { average(:value) }
end

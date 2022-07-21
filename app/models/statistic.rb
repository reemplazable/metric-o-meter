# frozen_string_literal: true

# == Schema Information
#
# Table name: statistics
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  timestamp  :datetime         not null
#  type       :integer          not null
#  value      :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Statistic < ApplicationRecord
  enum type: { avg_per_second: 0, avg_per_minute: 1, avg_per_hour: 2 }
  validates :name, :timestamp, :type, :value, presence: true
end

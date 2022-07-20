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
class Measure < ApplicationRecord
  validates :name, :timestamp, :value, presence: true
end

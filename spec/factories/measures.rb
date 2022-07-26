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
FactoryBot.define do
  factory :measure do
    timestamp { '2022-07-20 12:48:55' }
    name { 'MyString' }
    value { '9.99' }
  end
end

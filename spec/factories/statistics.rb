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
FactoryBot.define do
  factory :statistic do
    value { '9.99' }
    name { 'MyString' }
    timestamp { '2022-07-21 23:32:43' }
    type { 1 }
  end
end

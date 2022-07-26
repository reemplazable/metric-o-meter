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
FactoryBot.define do
  factory :statistic do
    value { '9.99' }
    name { 'MyString' }
    timestamp { DateTime.now }
    stat_type { 1 }
  end
end

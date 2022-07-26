# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::StatisticsController, type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  it 'lists current measures avg_per_minute' do
    statistic = create(:statistic)
    get '/api/v0/statistics', headers: headers
    expect(response.body).to(
      eq "[{\"c\":[{\"v\":\"Date(#{statistic.timestamp_msec})\"},null,{\"v\":\"#{statistic.value}\"}]}]"
    )
  end

  it 'lists current measures avg_per_second' do
    statistic = create(:statistic, stat_type: 0)
    get '/api/v0/statistics', headers: headers
    expect(response.body).to(
      eq "[{\"c\":[{\"v\":\"Date(#{statistic.timestamp_msec})\"},{\"v\":\"#{statistic.value}\"}]}]"
    )
  end

  it 'lists current measures avg_per_hour' do
    statistic = create(:statistic, stat_type: 2)
    get '/api/v0/statistics', headers: headers
    expect(response.body).to(
      eq "[{\"c\":[{\"v\":\"Date(#{statistic.timestamp_msec})\"},null,null,{\"v\":\"#{statistic.value}\"}]}]"
    )
  end

  it 'filters by name' do
    statistic = create(:statistic)
    create(:statistic, name: 'bogus_name')
    get '/api/v0/statistics', headers: headers, params: { name: statistic.name }
    expect(response.body).to(
      eq "[{\"c\":[{\"v\":\"Date(#{statistic.timestamp_msec})\"},null,{\"v\":\"#{statistic.value}\"}]}]"
    )
  end
end

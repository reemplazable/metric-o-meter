# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::StatisticsController, type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  it 'lists current measures' do
    statistics = create_list(:statistic, 3)
    get '/api/v0/statistics', headers: headers
    expect(response.body).to eq statistics.to_json
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::MeasuresController, type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  it 'lists current measures' do
    measures = create_list(:measure, 3)
    get '/api/v0/measures', headers: headers
    expect(response.body).to eq measures.to_json
  end

  describe '#create' do
    subject(:post_new_measure) { post '/api/v0/measures', params: payload, headers: }

    context 'with the correct params' do
      let(:payload) { attributes_for(:measure) }
      it 'creates a new measure' do
        expect { post_new_measure }.to change { Measure.count }.by(1)
        expect(response).to have_http_status :ok
      end
    end

    context 'without name' do
      let(:payload) { attributes_for(:measure).except(:name) }
      it 'fails creating a new measure' do
        expect { post_new_measure }.not_to(change { Measure.count })
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'without timestamp' do
      let(:payload) { attributes_for(:measure).except(:timestamp) }
      it 'fails creating a new measure' do
        expect { post_new_measure }.not_to(change { Measure.count })
        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context 'without value' do
      let(:payload) { attributes_for(:measure).except(:value) }
      it 'fails creating a new measure' do
        expect { post_new_measure }.not_to(change { Measure.count })
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  it 'shows a measure' do
    measure = create(:measure)
    get "/api/v0/measures/#{measure.id}", headers: headers
    expect(response.body).to eq measure.to_json
  end
end

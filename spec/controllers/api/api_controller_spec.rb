# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ApiController, type: :controller do
  controller do
    def index
      render_json({ foo: 'bar' }, status: :unprocessable_entity)
    end
  end

  it 'renders json and returns status' do
    get :index
    expect(response.body).to eq({ foo: 'bar' }.to_json)
    expect(response).to have_http_status(:unprocessable_entity)
  end
end

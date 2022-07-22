# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::ApiController, type: :controller do
  describe '#render_json' do
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

  describe 'rescue_from ActionLogic::PresenceError' do
    controller do
      def index
        raise ActionLogic::PresenceError
      end
    end

    it 'renders json and returns status' do
      get :index
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'rescue_from ActionLogic::MissingAttributeError' do
    controller do
      def index
        raise ActionLogic::MissingAttributeError
      end
    end

    it 'renders json and returns status' do
      get :index
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'rescue_from ActionLogic::AttributeTypeError' do
    controller do
      def index
        raise ActionLogic::AttributeTypeError
      end
    end

    it 'renders json and returns status' do
      get :index
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end

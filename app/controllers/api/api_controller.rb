# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    def render_json(obj, status: :ok)
      render json: obj.as_json, status:
    end
  end
end

# frozen_string_literal: true

module Api
  class ApiController < ActionController::API
    rescue_from ActionLogic::PresenceError, with: :unprocessable
    rescue_from ActionLogic::MissingAttributeError, with: :unprocessable
    rescue_from ActionLogic::AttributeTypeError, with: :unprocessable

    def render_json(obj, status: :ok)
      render json: obj.as_json, status:
    end

    def unprocessable
      head(:unprocessable_entity)
    end
  end
end

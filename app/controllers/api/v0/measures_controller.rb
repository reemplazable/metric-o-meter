# frozen_string_literal: true

module Api
  module V0
    class MeasuresController < Api::ApiController
      def index
        render_json Measure.all
      end

      def create
        measure = Measure.new(measure_params)
        if measure.valid?
          measure.save
          Rails.logger.debug { "Saved measure #{measure.id}" }
          head(:ok)
        else
          Rails.logger.error("Object not expected! #{request.body.read}")
          head(:unprocessable_entity)
        end
      end

      def show
        render_json Measure.find(params['id'])
      end

      private

      def measure_params
        params.permit(%i[name timestamp value])
      end
    end
  end
end

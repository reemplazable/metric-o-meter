# frozen_string_literal: true

module Api
  module V0
    class MeasuresController < Api::ApiController
      def index
        render_json Measure.all
      end

      def create
        context = create_measure
        return head(:ok) if context.success?

        Rails.logger.error("Object not expected! #{request.body.read}")
        head(:unprocessable_entity)
      end

      def show
        render_json Measure.find(params['id'])
      end

      private

      def create_measure
        NewMeasureUseCase.execute(measure_params: measure_parameters[:measure])
      end

      def measure_parameters
        # params.permit(%i[name timestamp value]).permit({ measure: %i[name timestamp value] })
        params.permit({ measure: %i[name timestamp value] })
      end
    end
  end
end

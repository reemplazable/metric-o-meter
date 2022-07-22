# frozen_string_literal: true

module Api
  module V0
    class StatisticsController < Api::ApiController
      def index
        render_json Statistic.all
      end
    end
  end
end

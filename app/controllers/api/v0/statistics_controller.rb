# frozen_string_literal: true

module Api
  module V0
    class StatisticsController < Api::ApiController
      def index
        render_json(avg_per_second + avg_per_minute + avg_per_hour)
      end

      private

      def avg_per_second
        statistics.avg_per_second.map do |s|
          { c: [{ v: "Date(#{s.timestamp_msec})" }, { v: s.value }] }
        end
      end

      def avg_per_minute
        statistics.avg_per_minute.map do |s|
          { c: [{ v: "Date(#{s.timestamp_msec})" }, nil, { v: s.value }] }
        end
      end

      def avg_per_hour
        statistics.avg_per_hour.map do |s|
          { c: [{ v: "Date(#{s.timestamp_msec})" }, nil, nil, { v: s.value }] }
        end
      end

      def statistics
        statistics = Statistic.time_ordered.select(:name, :value, :timestamp)
        statistics = statistics.named(name) if name

        statistics
      end

      def name
        params.permit(:name)[:name]
      end
    end
  end
end

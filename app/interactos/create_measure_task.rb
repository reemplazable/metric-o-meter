# frozen_string_literal: true

class CreateMeasureTask
  include ActionLogic::ActionTask

  validates_before measure_params: { presence: ->(measure_params) { verify_measure_params_presence(measure_params) } }

  def call
    measure = Measure.new(context.measure_params)
    return halt_create_measure unless measure.save

    Rails.logger.debug { "Saved measure #{measure.id}" }
    context.measure = measure
  end

  def self.verify_measure_params_presence(measure_params)
    %i[name timestamp value].all? { |s| measure_params&.key? s }
  end

  private

  def halt_create_measure
    context.halt! "Could not create a measure with #{context.measure_params}"
  end
end

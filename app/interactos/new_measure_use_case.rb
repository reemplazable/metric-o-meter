# frozen_string_literal: true

class NewMeasureUseCase
  include ActionLogic::ActionUseCase

  def call; end

  def tasks
    [CreateMeasureTask,
     CreateStatisticsTask]
  end
end

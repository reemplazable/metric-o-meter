# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V0::MeasuresController, type: :controller do
  describe '#create' do
    subject(:create_measure) { post :create }

    let(:context) { ActionLogic::ActionContext.new }

    before do
      allow(NewMeasureUseCase).to receive(:execute).and_return(context)
    end

    it 'triggers NewMeasureUseCase' do
      create_measure
      expect(NewMeasureUseCase).to have_received(:execute)
    end

    context 'with a successful context' do
      it 'returns ok status' do
        create_measure
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with a halted context' do
      let(:context) do
        context = ActionLogic::ActionContext.new
        context.halt!
        context
      end

      it 'returns unprocessable entityu status' do
        create_measure
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

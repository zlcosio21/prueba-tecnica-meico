
module Api
  module V1
    class PaymentsController < ApplicationController

      def create
        attrs = create_params.merge(status: :pending)
        provider = ProviderRouter.for(attrs[:payment_type] || attrs["payment_type"])
        payment = Payment.new(attrs)
        result = Payment::ProcessPayment.call(payment: payment, provider: provider)

        if result.success?
          payment.save!
          @payment = payment
          render template: 'api/v1/payments/create', status: :created
        else
          render json: { error: result.error }, status: :unprocessable_entity
        end
      rescue => e
        render_error(e)
      end

      private

      def render_error(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def create_params
        params.require(:payment).permit(
          :amount,
          :currency,
          :payment_type,
          details: {}
        )
      end
    end
  end
end

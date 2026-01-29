class Payment::ProcessPayment < ApplicationService
  attr_reader :payment, :provider

  def initialize(payment:, provider:)
    @payment = payment
    @provider = provider
  end

  def call
    result = provider.process(payment.attributes.symbolize_keys)

    if result[:error]
      payment.decline!(result["error"])
      return failure(result["error"])
    end

    payment.approve!(result)
    success(payment)
  rescue => e
    payment.error!(e.message)
    failure(e.message)
  end
end

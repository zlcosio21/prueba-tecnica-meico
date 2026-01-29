class Payment::ProcessPayment < ApplicationService
  attr_reader :payment, :provider

  def initialize(payment:, provider:)
    @payment = payment
    @provider = provider
  end

  def call
    provider = Payment::ProviderFactory.provider_for(payment)
    result = provider.process(payment)

    if result[:error]
      payment.decline!
      return failure(result[:error])
    end

    payment.approve!(result)
    success(payment)
  rescue => e
    payment.error!
    failure(e.message)
  end
end

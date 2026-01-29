# Factory para instanciar el provider externo adecuado para un Payment
class Payment::ProviderFactory
  def self.provider_for(payment)
    ProviderRouter.for(payment.payment_type)
  end
end

# ProviderRouter: selecciona el proveedor correcto según payment_type
class ProviderRouter
  PROVIDER_MAP = {
    "credit_card" => FastPay,
    "bank_transfer" => Bankio
  }

  def self.for(payment_type)
    PROVIDER_MAP.fetch(payment_type) { raise "Provider not supported: #{payment_type}" }
  end
end

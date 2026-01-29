# Bankio: proveedor para bank_transfer
class Bankio
  def self.process(params)
    {
      "transaction_state" => "processed",
      "ref_code" => "ABC-#{rand(100..999)}",
      "commission" => 2.5
    }
  end

  def self.name
    "Bankio"
  end
end

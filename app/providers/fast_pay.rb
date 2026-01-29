# FastPay: proveedor para credit_card
class FastPay
  def self.process(params)
    amount = params[:amount].to_f

    if amount < 10000
      {
        "status" => "succeeded",
        "charge_id" => SecureRandom.hex(6),
        "commission" => (amount * 0.03).round(2)
      }
    else
      { "error" => "card_declined" }
    end
  end

  def self.name
    "FastPay"
  end
end

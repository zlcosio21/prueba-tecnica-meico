
class Payment < ApplicationRecord
  enum :status, {
    pending: "pending",
    approved: "approved",
    declined: "declined",
    error: "error"
  }

  validates :amount, numericality: { greater_than: 0 }
  validates :currency, :payment_type, :details, presence: true

  def approve!(response, provider: nil)
    update!(
      status: :approved,
      internal_id: SecureRandom.uuid,
      provider_reference: response["charge_id"] || response["ref_code"],
      amount: amount + response["commission"].to_f
    )
  end

  def decline!(message)
    update(status: :declined)
  end

  def error!(message)
    update(status: :error)
  end
end

# frozen_string_literal: true

require "rails_helper"

describe Payment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:currency) }
    it { is_expected.to validate_presence_of(:payment_type) }
    it { is_expected.to validate_presence_of(:details) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe "enums" do
    it {
      expect(described_class.statuses).to eq({
        "pending" => "pending",
        "approved" => "approved",
        "declined" => "declined",
        "error" => "error"
      })
    }
  end

  describe "methods" do
    it "approves a payment" do
      payment = build(:payment, status: "pending", provider_reference: "abc", internal_id: SecureRandom.uuid)
      payment.approve!({ "charge_id" => "abc", "commission" => 0 }, provider: nil)
      expect(payment.status).to eq("approved")
    end

    it "declines a payment" do
      payment = build(:payment, status: "pending", provider_reference: "abc", internal_id: SecureRandom.uuid)
      payment.decline!("Declined by test")
      expect(payment.status).to eq("declined")
    end

    it "sets error on payment" do
      payment = build(:payment, status: "pending", provider_reference: "abc", internal_id: SecureRandom.uuid)
      payment.error!("fail")
      expect(payment.status).to eq("error")
    end
  end
end

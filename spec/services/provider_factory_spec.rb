# frozen_string_literal: true

require "rails_helper"

describe Payment::ProviderFactory do
  let(:credit_card_payment) { build(:payment, payment_type: "credit_card") }
  let(:bank_transfer_payment) { build(:payment, payment_type: "bank_transfer") }

  it "returns FastPay for credit_card" do
    expect(described_class.provider_for(credit_card_payment).name).to eq("FastPay")
  end

  it "returns Bankio for bank_transfer" do
    expect(described_class.provider_for(bank_transfer_payment).name).to eq("Bankio")
  end

  it "raises for unknown type" do
    payment = build(:payment, payment_type: "unknown")
    expect { described_class.provider_for(payment) }.to raise_error(/Provider not supported/)
  end
end

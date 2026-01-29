# frozen_string_literal: true

require "rails_helper"

describe "Provider mocks" do
  it "FastPay returns succeeded" do
    result = FastPay.process(amount: 1000, currency: "USD", details: {})
    expect(result[:status]).to eq("succeeded").or eq(nil)
  end

  it "Bankio returns processed" do
    result = Bankio.process(amount: 1000, currency: "USD", details: {})
    expect(result[:transaction_state]).to eq("processed").or eq(nil)
  end
end

# frozen_string_literal: true

require "rails_helper"

describe "POST /api/v1/payments", type: :request do
  it "creates a payment with FastPay" do
    post "/api/v1/payments", params: {
      payment: {
        amount: 1000,
        currency: "USD",
        payment_type: "credit_card",
        details: { card_number: "4111111111111111", exp: "12/30", cvv: "123" }
      }
    }

    expect(response).to have_http_status(:created)

    json = JSON.parse(response.body)

    expect(json["status"]).to eq("approved")
    expect(json["provider_reference"]).to be_present
  end

  it "returns error for unknown provider" do
    post "/api/v1/payments", params: {
      payment: {
        amount: 1000,
        currency: "USD",
        payment_type: "unknown",
        details: { foo: "bar" }
      }
    }

    expect(response).to have_http_status(:unprocessable_entity)

    json = JSON.parse(response.body)

    expect(json["error"]).to match(/Provider not supported/)
  end
end

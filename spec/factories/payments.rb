# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    amount { 1000 }
    currency { "USD" }
    payment_type { "credit_card" }
    status { "pending" }
    details {
      {
        "card_number" => "4111111111111111",
        "exp" => "12/30",
        "cvv" => "123"
      }
    }
  end
end

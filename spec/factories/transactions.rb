FactoryBot.define do
  FactoryBot.define do
    factory :transaction do
      credit_card_number { Faker::Finance.credit_card}
      credit_card_expiration_date {01/22}
      result { "failed" }
      invoice_id { Faker::Number.within(range: 1..10000) }
      invoice
    end
  end
end

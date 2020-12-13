FactoryBot.define do
  factory :item do
    name { "Mayfly"}
    description { "Dry Fly"}
    unit_price { 3.50 }
    # created_at { Time.now }
    # updated_at { Time.now }
    merchant
  end

  factory :merchant do
    name { "Charlies Fly Box"}
    # name { Faker::Merchant.name }
    # created_at { Time.now }
    # updated_at { Time.now }
  end

  def merchant_with_items(items_count: 5)
    FactoryBot.create(:merchant) do |merchant|
      FatoryBot.create_list(:items, items_count, merchant: merchant)
    end
  end
end

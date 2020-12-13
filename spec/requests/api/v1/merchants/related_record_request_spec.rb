require "rails_helper"

describe "Merchants API" do
  it "sends related items" do
    merchant_1 = create(:merchant)
    require "pry"; binding.pry
     merchant_1.items.create!(name: "Fries", description: "Deliciouso!", unit_price: 100.0)
     merchant_1.items.create!(name: "Ketchup", description: "It's red.", unit_price: 200.0)
     merchant_1.items.create!(name: "Mustard", description: "It's yellow.", unit_price: 300.0)
   merchant_2 = create(:merchant)
     item_2 = merchant_2.items.create!(name: "Rose", description: "red", unit_price: 400.0)

    require "pry"; binding.pry

    get "/api/v1/merchants/"

  end
end

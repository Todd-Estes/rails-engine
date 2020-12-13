require "rails_helper"

describe "Items API" do
  it "sends related items" do
    merchant_1 = create(:merchant)
    # id = merchant_1.id
    item_1 = merchant_1.items.create!(name: "Mayfly", description: "Dry Fly", unit_price: 3.5)
    # merchant_1.items.create!(name: "Wooly Booger", description: "Dry Fly", unit_price: 4.00)
    # merchant_1.items.create!(name: "San Juan Worm", description: "Worm", unit_price: 1.00)
    merchant_2 = create(:merchant)
    item_2 = merchant_2.items.create!(name: "Nymph", description: "Nymph", unit_price: 1.00)

    get "/api/v1/items/#{item_1.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:id]).to eq(item_1.merchant.id)
    expect(merchant[:id]).to_not eq(item_2.merchant.id)
  end
end

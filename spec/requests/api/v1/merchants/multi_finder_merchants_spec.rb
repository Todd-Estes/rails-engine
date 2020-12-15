require 'rails_helper'

describe "Multi finder for merchant" do
  it "can return multiple records that matches a set criteria" do
    merchant_1 = Merchant.create!(name: "Ring Worm Treatment", created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")
    merchant_2 = Merchant.create!(name: "Turing", created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    search_1 = {
      name: "ring"
    }
    get "/api/v1/merchants/find_all", params: search_1

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]
    expect(items.count).to eq(2)
  end

  it "can return multiple records that match created_at" do
    merchant_1 = Merchant.create!(name: "Ring Worm Treatment", created_at: "Thu, 12 Oct 2013 13:47:38 UTC +10:32", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")
    merchant_2 = Merchant.create!(name: "Turing", created_at: "Thu, 12 Oct 2013 13:47:38 UTC +10:32", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")

    search_2 = {
      created_at: "Thu, 12 Oct 2013 13:47:38 UTC +10:32"
    }
    get "/api/v1/merchants/find_all", params: search_2

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]
    expect(items.count).to eq(2)
  end

  it "can return multiple records that match updated_at" do
    merchant_1 = Merchant.create!(name: "Ring Worm Treatment", created_at: "Thu, 12 Oct 2013 13:47:38 UTC +10:32", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +12:34")
    merchant_2 = Merchant.create!(name: "Turing", created_at: "Thu, 12 Oct 2013 13:47:38 UTC +10:32", updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +12:34")

    search_3 = {
      updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +12:34"
    }
    get "/api/v1/merchants/find_all", params: search_3

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)
    items = json[:data]
    expect(items.count).to eq(2)
  end
end

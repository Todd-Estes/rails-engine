require 'rails_helper'

describe "Single Finder for merchant" do
  it "can return a single record that matches a set criteria" do
    merchant_1 = Merchant.create!(name: "Ringworm Treatment",
      created_at: "Thu, 12 Oct 2013 13:47:38 UTC +00:00",
      updated_at: "Thu, 22 Oct 2014 13:47:38 UTC +00:00")
    merchant_2 = Merchant.create!(name: "Turing",
      created_at: "Thu, 25 Oct 2018 13:47:38 UTC +00:00",
      updated_at: "Thu, 15 Oct 2020 13:47:38 UTC +00:00")

    search_1 = {
      name: "ring"
    }
    get "/api/v1/merchants/find?name=ring"
    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    merchant_a = json[:data]

    expect(merchant_a[:attributes][:name]).to eq(merchant_1.name)
  end

  it "can search by created_at" do
    merchant_2 = Merchant.create!(name: "Turing",
      created_at: "Thu, 25 Oct 2018 13:47:38 UTC +00:00",
      updated_at: "Thu, 15 Oct 2020 13:47:38 UTC +00:00")

    search_2 = {
      created_at: "Thu, 25 Oct 2018 13:47:38 UTC +00:00"
    }

    # get '/api/v1/merchants/find', params: search_2
    get "/api/v1/merchants/find?created_at=#{merchant_2.created_at}"

    expect(response).to be_successful

    json = JSON.parse(response.body, symbolize_names: true)

    merchant_b = json[:data]

    expect(merchant_b[:attributes][:name]).to eq(merchant_2.name)
  end

  it "can search by updated_at" do
    merchant_2 = Merchant.create!(name: "Turing",
      created_at: "Thu, 25 Oct 2018 13:47:38 UTC +00:00",
      updated_at: "Thu, 15 Oct 2020 13:47:38 UTC +00:00")

    search_3 = {
      updated_at: "Thu, 15 Oct 2020 13:47:38 UTC +00:00"
    }
    
    # get '/api/v1/merchants/find', params: search_3
    get "/api/v1/merchants/find?updated_at=#{merchant_2.updated_at}"


    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    merchant_c = json[:data]

    expect(merchant_c[:attributes][:name]).to eq(merchant_2.name)
  end
end

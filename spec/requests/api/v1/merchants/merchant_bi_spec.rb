require 'rails_helper'

describe "Merchant Business Intelligence Endpoints:" do
  it "returns a variable number of merchants ranked by total revenue" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)


    invoice_1 = create(:invoice, merchant_id: merchant_1.id)
    create(:transaction, result: "success", invoice_id: invoice_1.id)
    create(:invoice_item, quantity: 20, unit_price: 100.00, invoice_id: invoice_1.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, result: "success", invoice_id: invoice_2.id)
    create(:invoice_item, quantity: 15, unit_price: 100.00, invoice_id: invoice_2.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_3 = create(:invoice, merchant_id: merchant_3.id)
    create(:transaction, result: "success", invoice_id: invoice_3.id)
    create(:invoice_item, quantity: 10, unit_price: 100.00, invoice_id: invoice_3.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_4 = create(:invoice, merchant_id: merchant_4.id)
    create(:transaction, result: "success", invoice_id: invoice_4.id)
    create(:invoice_item, quantity: 5, unit_price: 100.00, invoice_id: invoice_4.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_5 = create(:invoice, merchant_id: merchant_5.id)
    create(:transaction, result: "success", invoice_id: invoice_5.id)
    create(:invoice_item, quantity: 1, unit_price: 100.00, invoice_id: invoice_5.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_6 = create(:invoice, merchant_id: merchant_1.id)
    create(:transaction, result: "failed", invoice_id: invoice_6.id)
    create(:invoice_item, invoice_id: invoice_6.id)

    invoice_7 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, result: "failed", invoice_id: invoice_7.id)
    create(:invoice_item, invoice_id: invoice_7.id)

    invoice_8 = create(:invoice, merchant_id: merchant_3.id)
    create(:transaction, result: "failed", invoice_id: invoice_8.id)
    create(:invoice_item, invoice_id: invoice_8.id)

    quantity = 5
    get "/api/v1/merchants/most_revenue?quantity=#{quantity}"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(quantity)

    expect(json[:data][0][:attributes][:name]).to eq(merchant_1.name)
    expect(json[:data][0][:id].to_i).to eq(merchant_1.id)

    expect(json[:data][1][:attributes][:name]).to eq(merchant_2.name)
    expect(json[:data][1][:id].to_i).to eq(merchant_2.id)

    expect(json[:data][2][:attributes][:name]).to eq(merchant_3.name)
    expect(json[:data][2][:id].to_i).to eq(merchant_3.id)
  end


  it "returns a variable number of merchants ranked by total number of items sold" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id)
    create(:transaction, result: "success", invoice_id: invoice_1.id)
    create(:invoice_item, quantity: 20, unit_price: 100.00, invoice_id: invoice_1.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_2 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, result: "success", invoice_id: invoice_2.id)
    create(:invoice_item, quantity: 15, unit_price: 100.00, invoice_id: invoice_2.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_3 = create(:invoice, merchant_id: merchant_3.id)
    create(:transaction, result: "success", invoice_id: invoice_3.id)
    create(:invoice_item, quantity: 10, unit_price: 100.00, invoice_id: invoice_3.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_4 = create(:invoice, merchant_id: merchant_4.id)
    create(:transaction, result: "success", invoice_id: invoice_4.id)
    create(:invoice_item, quantity: 5, unit_price: 100.00, invoice_id: invoice_4.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_5 = create(:invoice, merchant_id: merchant_5.id)
    create(:transaction, result: "success", invoice_id: invoice_5.id)
    create(:invoice_item, quantity: 1, unit_price: 100.00, invoice_id: invoice_5.id, item_id: create(:item, unit_price: 100.00).id)

    invoice_6 = create(:invoice, merchant_id: merchant_1.id)
    create(:transaction, result: "failed", invoice_id: invoice_6.id)
    create(:invoice_item, invoice_id: invoice_6.id)

    invoice_7 = create(:invoice, merchant_id: merchant_2.id)
    create(:transaction, result: "failed", invoice_id: invoice_7.id)
    create(:invoice_item, invoice_id: invoice_7.id)

    invoice_8 = create(:invoice, merchant_id: merchant_3.id)
    create(:transaction, result: "failed", invoice_id: invoice_8.id)
    create(:invoice_item, invoice_id: invoice_8.id)

    quantity = 4
    get "/api/v1/merchants/most_items?quantity=#{quantity}"

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(quantity)

    expect(json[:data][0][:attributes][:name]).to eq(merchant_1.name)
    expect(json[:data][0][:id].to_i).to eq(merchant_1.id)

    expect(json[:data][1][:attributes][:name]).to eq(merchant_2.name)
    expect(json[:data][1][:id].to_i).to eq(merchant_2.id)

    expect(json[:data][2][:attributes][:name]).to eq(merchant_3.name)
    expect(json[:data][2][:id].to_i).to eq(merchant_3.id)
    end

    it "returns total revenue for an individual merchant" do
      merchant_1 = create(:merchant)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id)
      create(:transaction, result: "success", invoice_id: invoice_1.id)
      create(:invoice_item, quantity: 20, unit_price: 100.00, invoice_id: invoice_1.id, item_id: create(:item, unit_price: 100.00).id)

      invoice_2 = create(:invoice, merchant_id: merchant_1.id)
      create(:transaction, result: "success", invoice_id: invoice_1.id)
      create(:invoice_item, quantity: 30, unit_price: 50.00, invoice_id: invoice_1.id, item_id: create(:item, unit_price: 50.00).id)

      invoice_3 = create(:invoice, merchant_id: merchant_1.id)
      create(:transaction, result: "success", invoice_id: invoice_1.id)
      create(:invoice_item, quantity: 10, unit_price: 100.00, invoice_id: invoice_1.id, item_id: create(:item, unit_price: 100.00).id)

      get "/api/v1/merchants/#{merchant_1.id}/revenue"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:attributes][:revenue].to_f.round(2)).to eq(13500.0)



    end
  end

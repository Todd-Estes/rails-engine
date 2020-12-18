require 'rails_helper'

describe "Revenue_dates Business Intelligence Endpoint:" do
  it "can get revenue between two dates" do
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

    get "/api/v1/revenue?start=2019-03-09&end=2020-12-18"

      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:id]).to be_nil
      expect(json[:data][:attributes][:revenue].to_f.round(2)).to eq(5100.0)
    end
  end

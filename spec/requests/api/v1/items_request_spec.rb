require "rails_helper"

describe "Items API" do
  it 'sends a list of items' do
      create_list(:item, 3)

      get "/api/v1/items"


      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.count).to eq (3)

      items.each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(Integer)

        expect(item).to have_key(:name)
        expect(item[:name]).to be_an(String)

        expect(item).to have_key(:description)
        expect(item[:description]).to be_an(String)

        expect(item).to have_key(:unit_price)
        expect(item[:unit_price]).to be_an(Float)
      end
    end

    it "can get one item by its id" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key(:id)
      expect(item[:id]).to eq(id)

      expect(item).to have_key(:name)
      expect(item[:name]).to be_a(String)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)
    end

    it "can create a new item" do
      id = create(:merchant).id

      item_params = ({
                  name: "Wooly Booger",
                  description: "Dry Fly",
                  unit_price: 4.00,
                  merchant_id: id
                     })
      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
    end

    it "can update an existing item" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "San Juan Worm" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("San Juan Worm")
    end

    it "can destroy an item" do
      item = create(:item)
      merchant_id = Merchant.last.id

      expect(Item.count).to eq(1)

      delete "/api/v1/merchants/#{merchant_id}"


      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
end
require "rails_helper"

RSpec.describe Revenue do
  it "exists" do
    data = (1000)

    profit = Revenue.new(data)

    expect(profit).to be_a Revenue
    expect(profit.revenue).to eq(1000)
    expect(profit.id).to be_nil
  end
end

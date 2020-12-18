class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  belongs_to :merchant

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.create_search(create_time)
    where(created_at: create_time)
  end

  def self.update_search(update_time)
    where(updated_at: update_time)
  end

  def self.price_search(price)
    where(unit_price: price)
  end

  def self.merchant_search(merchant_id)
    where(merchant_id: merchant_id)
  end

  def self.search(attribute, query)
    where("#{attribute} ILIKE ?", "%#{query}%")
  end
end

class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.search(name)
      where("name ILIKE ?", "%#{name}%")
  end

  def self.create_search(create_time)
    where(created_at: create_time)
  end

  def self.update_search(update_time)
    where(updated_at: update_time)
  end

  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.most_items(quantity)
    select("merchants.*, SUM(invoice_items.quantity) AS items_sold")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .group(:id)
      .order('items_sold DESC')
      .limit(quantity)
  end
  #


  def self.revenue(merchant_id)
    total_revenue = self.joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .where(id: merchant_id)
      .sum('unit_price * quantity')
    Revenue.new(total_revenue)
    end
end

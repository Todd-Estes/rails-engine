class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  # #
  # def most_revenue(quantity)
  #   SELECT merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue FROM merchants
  #   INNER JOIN invoices ON merchants.id = invoices.merchant_id
  #   INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id
  #   INNER JOIN transactions ON invoices.id = transactions.invoice_id
  #   WHERE transactions.result = 'success' GROUP BY merchants.id
  #   ORDER BY revenue DESC LIMIT 3;
  # end
  # #
  def self.most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  # # def most_items(quantity)
  # #   SELECT merchants.*, SUM(invoice_items.quantity) AS items_sold
  # #   FROM "merchants" INNER JOIN "invoices"
  # #   ON "invoices"."merchant_id" = "merchants"."id"
  # #   INNER JOIN "invoice_items" ON "invoice_items"."invoice_id" = "invoices"."id"
  # #   INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id"
  # #   WHERE "transactions"."result" = 'success' AND "invoices"."status" = 'shipped'
  # #   GROUP BY "merchants"."id" ORDER BY items_sold DESC LIMIT 3;
  # # end
  # #
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
  # def revenue(id)
  #   SELECT SUM(invoice_items.quantity * invoice_items.unit_price) FROM merchants INNER JOIN invoices ON merchants.id = invoices.merchant_id INNER JOIN invoice_items ON invoice_items.invoice_id = invoices.id INNER JOIN transactions ON invoices.id = transactions.invoice_id WHERE transactions.result = 'success' AND "invoices"."status" = 'shipped' AND merchants.id = 1;
  # end

  def self.revenue(merchant_id)
    total_revenue = self.joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .where(id: merchant_id)
      .sum('unit_price * quantity')
    Revenue.new(total_revenue)
    end
end

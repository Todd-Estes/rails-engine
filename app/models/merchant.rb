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
  #
  def most_revenue(quantity)
    select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_prices) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .group(:id)
      .order('revenue DESC')
      limit(quantity)
  end


end

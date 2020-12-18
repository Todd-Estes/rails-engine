class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :merchant
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items


  default_scope { order(id: :asc) }

  scope :successful, -> { where(status: "shipped") }

  def self.revenue_dates(start_date, end_date)
    total = joins(:invoice_items, :transactions)
      .merge(Transaction.unscoped.successful)
      .merge(Invoice.unscoped.successful)
      .where(created_at: Date.parse(start_date.to_s).beginning_of_day..Date.parse(end_date.to_s).end_of_day)
      .sum('invoice_items.quantity * invoice_items.unit_price')
    Revenue.new(total)
  end
end

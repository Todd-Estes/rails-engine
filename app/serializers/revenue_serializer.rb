class RevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :revenue

  # belongs_to :merchant
  #
  # has_many :invoice_items
  # has_many :invoices, through: :invoice_items
end

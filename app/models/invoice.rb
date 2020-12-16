class Invoice < ApplicationRecord
  validates_presence_of :status

  belongs_to :merchant
  belongs_to :customer

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items


  default_scope { order(id: :asc) }

  scope :successful, -> { where(status: "shipped") }
end

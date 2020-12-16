class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number, :credit_card_expiration_date, :result

  belongs_to :invoice

  default_scope { order(id: :asc) }

  scope :successful, -> { where(result: "success") }

end

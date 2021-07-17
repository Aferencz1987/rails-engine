class Invoice < ApplicationRecord
  belongs_to :merchant
  belongs_to :customer
  belongs_to :transaction
  has_many :invoice_items
  has_many :items, through: :invoice_items
end

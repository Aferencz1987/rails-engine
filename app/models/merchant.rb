class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  # has_many :invoice_items, through: :items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.top_revenue(quantity)
    joins(items: [invoices: :transactions])
    #ruby knows the way from one to the other via all the other tables and previously stated relationships
    .select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .where('result = ?', 'success')
    .where('status = ?', 'shipped')
    .group('merchants.id')
    .order('revenue desc')
    .limit(quantity)
  end

  def self.most_items_sold(quantity)
    joins(items: [invoices: :transactions])
    .select('merchants.*, sum(invoice_items.quantity) as count')
    .where('result = ?', 'success')
    .where('status = ?', 'shipped')
    .group('merchants.id')
    .order('count desc')
    .limit(quantity)
  end
end

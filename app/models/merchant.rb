class Merchant  < ApplicationController
  has_many :items
  has_many :invoices
end

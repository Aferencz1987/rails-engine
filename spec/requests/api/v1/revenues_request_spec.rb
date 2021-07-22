require 'rails_helper'

describe 'Revenue API' do
  before(:each) do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    merchant4 = create(:merchant)
    customer1 = create(:customer)
    invoice1 = create(:invoice, merchant: merchant1, customer: customer1)
    invoice2 = create(:invoice, merchant: merchant2, customer: customer1)
    invoice3 = create(:invoice, merchant: merchant3, customer: customer1)
    invoice4 = create(:invoice, merchant: merchant4, customer: customer1)
    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice1)
    transaction3 = create(:transaction, invoice: invoice1)
    transaction4 = create(:transaction, invoice: invoice2)
    transaction5 = create(:transaction, invoice: invoice3)
    transaction6 = create(:transaction, invoice: invoice4)



  end
  it 'can top revenue by amount' do


    quantity = 2

    get "/api/v1/revenue/merchants?quantity=#{quantity}"
    expect(response).to be_successful
    top_merchants = JSON.parse(response.body, symbolize_names: true)

    expect(top_merchants[:data][0][:attributes]).to have_key(:revenue)
    expect(top_merchants[:data].count).to eq(2)
  end
end

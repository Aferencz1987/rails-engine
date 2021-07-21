require 'rails_helper'

describe 'Revenue API' do
  it 'can top revenue by amount' do
    create_list(:merchant, 10)
    quantity = 6

    get "/api/v1/revenue/merchants?quantity=#{quantity}"
    expect(response).to be_successful
    top_merchants = JSON.parse(response.body, symbolize_names: true)

    expect(top_merchants[:data][0][:attributes]).to have_key(:revenue)
    expect(top_merchants[:data].count).to eq(6)
  end
end

require 'rails_helper'

describe 'Merchant API' do
  describe 'merchant index calls' do
    it 'gets a list of merchants' do
      create_list(:merchant, 10)

      get '/api/v1/merchants'
      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(10)
      expect(merchants[:data].first[:name]).to be_a(String)
    end

    it 'shows 20 merchants by default' do
      create_list(:merchant, 70)
      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)
    end

    it 'shows merchants by user designated number per page' do
      create_list(:merchant, 70)
      get '/api/v1/merchants?per_page=50'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(50)
    end
  end

  describe 'merchant show call' do
    it 'can show 1 merchant' do
      merchant_id = create(:merchant).id
      get "/api/v1/merchants/#{merchant_id}"

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to eq(merchant_id)
      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end

  describe 'merchant items call' do
    it 'can show all a merchants items' do
      merchant = create(:merchant)
      item1 = create(:item, merchant: merchant)
      item2 = create(:item, merchant: merchant)

      get "/api/v1/merchants/#{merchant.id}/items"

      expect(response).to be_successful

      merchant_items = JSON.parse(response.body, symbolize_names: true)

      expect(merchant_items.count).to eq(2)
    end
  end
end

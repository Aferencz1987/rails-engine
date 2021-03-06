require 'rails_helper'

describe 'Merchant API' do
  describe 'merchant index calls' do
    it 'gets a list of merchants' do
      create_list(:merchant, 10)

      get '/api/v1/merchants'
      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(10)
      expect(merchants[:data].first[:attributes][:name]).to be_a(String)

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
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to eq(merchant_id.to_s)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to have_key(:name)
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
      expect(merchant_items[:data].count).to eq(2)
      #test for serializer here by checking structure (keys and such)
    end
  end

  describe 'merchant/s find by name' do
    it 'will error if no search param find' do
      create_list(:merchant, 4)
      get '/api/v1/merchants/find?'

      expect(response).to_not be_successful
    end

    it 'finds a merchant by partial name' do
      merchant = create(:merchant, name: "Max")
      merchant1 = create(:merchant, name: "Maxene")
      bad_merchant = create(:merchant, name: "Axe")

      get '/api/v1/merchants/find?name=m'
      expect(response).to be_successful
      merchant_result = JSON.parse(response.body, symbolize_names: true)
      name = merchant_result[:data][:attributes][:name]
      expect(merchant_result.count).to eq(1)
      expect(name).to eq(merchant.name)
      expect(name).to_not eq(bad_merchant.name)

      get '/api/v1/merchants/find?name=ma'
      expect(response).to be_successful
      merchant_result = JSON.parse(response.body, symbolize_names: true)
      name = merchant_result[:data][:attributes][:name]
      expect(name).to eq(merchant.name)
      expect(name).to_not eq(bad_merchant.name)

      get '/api/v1/merchants/find?name=max'
      expect(response).to be_successful
      merchant_result = JSON.parse(response.body, symbolize_names: true)
      name = merchant_result[:data][:attributes][:name]
      expect(name).to eq(merchant.name)
      expect(name).to_not eq(bad_merchant.name)
    end

    it 'will error if no search param find_all' do
      create_list(:merchant, 4)

      get '/api/v1/merchants/find_all?'
      expect(response).to_not be_successful
    end

    it 'finds merchants by partial name' do
      merchant = create(:merchant, name: "Max")
      merchant1 = create(:merchant, name: "Maxene")
      bad_merchant = create(:merchant, name: "Axe")

      get '/api/v1/merchants/find_all?name=m'
      expect(response).to be_successful
      merchant_result = JSON.parse(response.body, symbolize_names: true)
      name = merchant_result[:data][0][:attributes][:name]
      expect(merchant_result[:data].count).to eq(2)
      expect(name).to eq(merchant.name)
      expect(name).to_not eq(bad_merchant.name)

      get '/api/v1/merchants/find_all?name=ma'
      expect(response).to be_successful
      merchant_result = JSON.parse(response.body, symbolize_names: true)
      name = merchant_result[:data][0][:attributes][:name]
      expect(name).to eq(merchant.name)
      expect(name).to_not eq(bad_merchant.name)

      get '/api/v1/merchants/find_all?name=max'
      expect(response).to be_successful
      merchant_result = JSON.parse(response.body, symbolize_names: true)
      name = merchant_result[:data][0][:attributes][:name]
      expect(name).to eq(merchant.name)
      expect(name).to_not eq(bad_merchant.name)
    end
  end
end

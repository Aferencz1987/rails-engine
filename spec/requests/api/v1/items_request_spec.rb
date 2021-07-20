require 'rails_helper'

describe 'Item API' do
  describe 'item index calls' do
    it 'gets a list of items' do
      merchant = create(:merchant)
      create_list(:item, 10, merchant: merchant)

      get '/api/v1/items'
      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(10)
      expect(items[:data].first[:attributes][:name]).to be_a(String)

    end

    it 'shows 20 items by default' do
      merchant = create(:merchant)
      create_list(:item, 70, merchant: merchant)
      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
    end

    it 'shows items by user designated number per page' do
      merchant = create(:merchant)
      create_list(:item, 70, merchant: merchant)
      get '/api/v1/items?per_page=50'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(50)
    end
  end

  describe 'item show call' do
    it 'can show 1 item' do
      merchant = create(:merchant)
      item_id = create(:item, merchant: merchant).id
      get "/api/v1/items/#{item_id}"

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)
      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to eq(item_id.to_s)
      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to have_key(:name)
    end
  end

  describe 'item merchant call' do
    it 'can show an items merchant' do
      merchant = create(:merchant)
      item1 = create(:item, merchant: merchant)

      get "/api/v1/items/#{item1.id}/merchant"
      expect(response).to be_successful
      item_merchant = JSON.parse(response.body, symbolize_names: true)
      expect(item_merchant[:data][:attributes][:name]).to eq(merchant.name)
      #test for serializer here by checking structure (keys and such)
    end
  end

  describe 'item find by name' do
    it 'will error if no search param' do
      merchant = create(:merchant)
      create_list(:item, 4, merchant: merchant)
      get '/api/v1/items/find?'

      expect(response).to_not be_successful
    end

    it 'finds item by partial name' do
      merchant = create(:merchant)
      item = create(:item, name: "Max", merchant: merchant)
      bad_item = create(:item, name: "Axe", merchant: merchant)

      get '/api/v1/items/find?name=m'
      expect(response).to be_successful
      item_result = JSON.parse(response.body, symbolize_names: true)
      name = item_result[:data][:attributes][:name]
      expect(name).to eq(item.name)
      expect(name).to_not eq(bad_item.name)

      get '/api/v1/merchants/find?name=ma'
      expect(response).to be_successful
      item_result = JSON.parse(response.body, symbolize_names: true)
      require "pry"; binding.pry
      name = item_result[:data][:attributes][:name]
      expect(name).to eq(item.name)
      expect(name).to_not eq(bad_item.name)

      get '/api/v1/merchants/find?name=max'
      expect(response).to be_successful
      item_result = JSON.parse(response.body, symbolize_names: true)
      name = item_result[:data][:attributes][:name]
      expect(name).to eq(item.name)
      expect(name).to_not eq(bad_item.name)
    end
  end
end

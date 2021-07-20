require 'rails_helper'

RSpec.describe 'item serializer' do
  it 'returns serialized items' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    serializer = ItemSerializer.new(item)
    expect(serializer.serializable_hash[:name]).to eq(item.name)
  end
end

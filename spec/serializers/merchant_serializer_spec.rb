require 'rails_helper'

RSpec.describe 'merchant serializer' do
  it 'returns serialized merchants' do
    merchant = create(:merchant)
    serializer = MerchantSerializer.new(merchant)
    expect(serializer.serializable_hash[:name]).to eq(merchant.name)
  end
end

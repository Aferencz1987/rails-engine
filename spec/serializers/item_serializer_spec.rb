require 'rails_helper'

RSpec.describe 'item serializer' do
  it 'returns serialized items' do
    item = create(:item)
    serializer = MerchantSerializer.new(item)
    expect(serializer.serializable_hash[:name]).to eq(item.name)
  end
end

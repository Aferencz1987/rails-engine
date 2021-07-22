class MostItemSerializer < ActiveModel::Serializer
  type :item_sold
  attributes :name, :count
end

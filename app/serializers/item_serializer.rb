# Public: Serializes item objects
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :completed
end

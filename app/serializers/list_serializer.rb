# Public: Serializes list objects
class ListSerializer < ActiveModel::Serializer
  attributes :id, :name
end

# Public: Serializes list objects
class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :permission
  has_many :items

  def filter(keys)
    keys.delete :items if serialization_options[:no_associations]
    keys
  end
end

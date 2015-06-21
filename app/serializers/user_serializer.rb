# Public: Serializes user objects
class UserSerializer < ActiveModel::Serializer
  attributes :id, :user_name
end

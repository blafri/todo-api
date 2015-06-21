# Public: Model class for the items table in the database
class Item < ActiveRecord::Base
  belongs_to :list

  validates :list, presence: true
  validates :name, presence: true
end

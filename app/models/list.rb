# Public: Model class for the lists table in the database
class List < ActiveRecord::Base
  belongs_to :user
  has_many :items

  validates :user, presence: true
  validates :name, presence: true
end

# Public: Model class for the lists table in the database
class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
end

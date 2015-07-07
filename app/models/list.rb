# Public: Model class for the lists table in the database
class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true
  validates :permission, inclusion: { in: %w(private viewable open),
    message: "%{value} is not a valid permission" }

  scope :lists_for, ->(user) { where(user_id: user.id) }
end

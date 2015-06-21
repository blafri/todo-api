# Public: Model class for the users table in the database
class User < ActiveRecord::Base
  has_secure_password

  has_many :lists

  validates :user_name, presence: true, uniqueness: { case_sensitive: false }
end

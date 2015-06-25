# Public: Model class for the users table in the database
class User < ActiveRecord::Base
  has_secure_password

  has_many :lists, dependent: :destroy

  validates :user_name, presence: true, uniqueness: { case_sensitive: false }

  # Public: Determins if the user is an admin user
  #
  # Returns boolean value indicating weather the user is an admin user
  def admin?
    role == 'admin'
  end
end

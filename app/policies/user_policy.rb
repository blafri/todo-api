# Public: Authorization policy for user objects
class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def create?
    user.admin?
  end

  def destroy?
    create?
  end
end

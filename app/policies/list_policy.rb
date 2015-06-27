# Public: Authorization policy for list objects
class ListPolicy < ApplicationPolicy
  def create?
    list_owner?
  end

  def destroy?
    create?
  end

  def list_owner?
    record.user_id == user.id
  end
end

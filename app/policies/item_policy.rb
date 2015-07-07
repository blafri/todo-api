# Public: Authorization policy for item objects
class ItemPolicy < ApplicationPolicy
  def create?
    record.list.user_id == user.id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end
end

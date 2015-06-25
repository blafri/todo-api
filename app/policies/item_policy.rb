# Public: Authorization policy for item objects
class ItemPolicy < ApplicationPolicy
  def create?
    item_owner?
  end

  def destroy?
    create?
  end

  def item_owner?
    record.list.user_id == user.id
  end
end

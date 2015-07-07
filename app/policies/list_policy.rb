# Public: Authorization policy for list objects
class ListPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def create?
    record.user_id == user.id
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  # Pulic: Scope for list policy
  class Scope < Scope
    def resolve
      scope.lists_for(user)
    end
  end
end

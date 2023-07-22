class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user&.admin? || user&.has_role?(:moderator)

      scope.all
    end
  end

  def index?
    condition?
  end

  def create?
    condition?
  end

  def update?
    condition?
  end

  def destroy?
    user.admin?
  end

  private

  def condition?
    user&.admin? || user&.has_role?(:moderator)
  end
end

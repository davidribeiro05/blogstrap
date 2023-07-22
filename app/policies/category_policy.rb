class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      raise Pundit::NotAuthorizedError unless user&.admin?

      scope.all
    end
  end

  def index?
    user&.admin?
  end

  def create?
    condition?
  end

  def update?
    condition?
  end

  def destroy?
    condition?
  end

  private

  def condition?
    user.admin?
  end
end

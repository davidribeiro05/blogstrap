class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user&.id
  end

  def update?
    condition?
  end

  def destroy?
    condition?
  end

  private

  def condition?
    user&.id == record.user.id
  end
end

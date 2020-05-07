# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    self?
  end

  def update?
    self?
  end

  def destroy?
    self?
  end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end

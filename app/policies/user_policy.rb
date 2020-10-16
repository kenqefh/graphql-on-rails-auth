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

  private

  def self?
    record.id == user.id
  end
end

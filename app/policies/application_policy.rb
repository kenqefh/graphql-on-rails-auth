# frozen_string_literal: true

class ApplicationPolicy < ActionPolicy::Base
  # Configure additional authorization contexts here
  # (`user` is added by default).
  #
  #   authorize :account, optional: true
  #
  # Read more about authoriztion context: https://actionpolicy.evilmartians.io/#/authorization_context

  private

  # Define shared methods useful for most policies.
  def self?
    record.id == user.id
  end
end

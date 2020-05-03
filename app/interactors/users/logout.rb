# frozen_string_literal: true

class Users::Logout < BaseInteractor

  def call
    context.message = 'You have logged out'
  end
end

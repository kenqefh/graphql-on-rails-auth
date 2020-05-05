# frozen_string_literal: true

class Users::Login < BaseInteractor
  delegate :email, :password, to: :context

  def call
    return nil if password.empty?

    user = User.find_by_email(email)

    if user
      if user.authenticate(password)
        context.message = 'Successfully logged in'
        context.user = user
      else
        context.message = 'That seems like a wrong password'
      end
    else
      context.message = 'Could not find an account with that email, please sign up instead'
    end
  end
end

# frozen_string_literal: true

module Users
  class Update < BaseInteractor
    delegate :user, :attributes, to: :context

    def call
      if user.update attributes
        context.user = user
      else
        context.fail! messages: user.errors.full_messages, user: nil
      end
    end
  end
end

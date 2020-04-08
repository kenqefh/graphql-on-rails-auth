# frozen_string_literal: true

module Users
  class Create < BaseInteractor
    delegate :attributes, to: :context

    def call
      user = User.create(**attributes)

      if user.persisted?
        context.user = user
      else
        context.fail! errors: user.errors
      end
    end
  end
end

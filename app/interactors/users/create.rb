# frozen_string_literal: true

module Users
  class Create < BaseInteractor
    delegate :attributes, to: :context

    def call
      user = User.create(**attributes)

      if user.persisted?
        context.user = user
        context.message = 'You have successfully signed up'
        context.token = user.generate_token
        ENV['JWT_TOKEN'] = context.token
      else
        context.fail! errors: user.errors.full_messages, user: nil
      end
    end
  end
end

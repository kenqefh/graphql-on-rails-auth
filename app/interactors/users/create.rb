# frozen_string_literal: true

module Users
  class Create < BaseInteractor
    delegate :attributes, to: :context

    def call
      user = User.create(**attributes)

      context.user = user
    end
  end
end

# frozen_string_literal: true

module Users
  class Create < BaseInteractor
    delegate :attributes, to: :context

    def call
      context.user = User.create!(**attributes)
    rescue ActiveRecord::RecordInvalid => e
      context.fail! messages: [e.message]
    end
  end
end

# frozen_string_literal: true

module Users
  class Update < BaseInteractor
    delegate :user, :attributes, to: :context

    def call
      context.user = user.update! attributes
    rescue ActiveRecord::RecordInvalid => e
      context.fail! message: e.message
    end
  end
end

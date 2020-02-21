# frozen_string_literal: true

module Users
  class Delete < BaseInteractor
    delegate :user, to: :context

    def call
      user.destroy!
    rescue ActiveRecord::RecordNotDestroyed => e
      context.fail! message: e.message
    end
  end
end

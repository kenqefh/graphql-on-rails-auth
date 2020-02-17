# frozen_string_literal: true

module Users
  class Get < BaseInteractor
    delegate :id, to: :context
    
    def call
      context.user = User.find(id)
    rescue ActiveRecord::RecordNotFound => e
      context.fail! messages: [e.message]
    end
  end
end

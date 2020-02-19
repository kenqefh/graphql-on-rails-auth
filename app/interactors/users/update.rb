# frozen_string_literal: true

module Users
  class Update < BaseInteractor
    delegate :id, :attributes, to: :context

    def call
      user = Users::Get.call(id: id).user

      context.user = user.update! attributes
    rescue ActiveRecord::RecordInvalid => e
      context.fail! message: e.message
    end
  end
end

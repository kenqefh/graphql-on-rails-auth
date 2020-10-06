# frozen_string_literal: true

class Mutations::Users::Delete < Mutations::BaseMutation
  argument :user_id, ID, required: true

  field :message, String, null: true
  field :errors, [String], null: true

  def resolve(user_id:)
    user = ::Users::Get.call(id: user_id).user

    authorize! user, to: :destroy?

    result = ::Users::Delete.call(user: user)

    {
      message: result.message,
      errors: result.errors
    }
  end
end

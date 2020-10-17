# frozen_string_literal: true

class Mutations::Users::Update < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :first_name, String, required: false
  argument :last_name, String, required: false
  argument :email, String, required: false

  field :user, Types::UserType, null: true
  field :errors, [String], null: true

  def resolve(user_id:, **args)
    user = ::Users::Get.call(id: user_id).user

    authorize! user, to: :update? if user

    result = ::Users::Update.call(user: user, attributes: args)

    {
      user: result.user,
      errors: result.messages
    }
  end
end

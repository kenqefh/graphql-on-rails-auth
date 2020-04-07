# frozen_string_literal: true

class Mutations::Users::Create < Mutations::BaseMutation
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true

  field :user, Types::UserType, null: true
  field :errors, Types::ValidationErrorsType, null: true

  def resolve(**args)
    result_context = ::Users::Create.call(attributes: *args)

    if result_context.success?
      { user: result_context.user, errors: nil }
    else
      { user: nil, errors: result_context.errors }
    end
  end
end

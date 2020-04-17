# frozen_string_literal: true

class Mutations::Users::Delete < Mutations::BaseMutation
  argument :user_id, ID, required: true

  field :message, String, null: true
  field :errors, [String], null: true
   
  def resolve(user_id: )
    user = User.find(user_id)

    result = ::Users::Delete.call(user: user)
    binding.pry

    if result.success?
      { message: result.message }
    else
      { errors: result.errors.messages }
    end
  end
end

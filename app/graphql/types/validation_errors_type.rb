# frozen_string_literal: true

class Types::ValidationErrorsType < Types::BaseObject
  field :details, String, null: false
  field :full_messages, String, null: false

  def details
    object.details
  end
end

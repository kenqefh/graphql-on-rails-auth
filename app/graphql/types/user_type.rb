# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :full_name, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def full_name
      [object.first_name, object.last_name].compact.join(' ')
    end

    def self.authorized?(object, context)
      super &&
        allowed_to?(
          :show?,
          object,
          context: { user: context[:current_user] }
        )
    end
  end
end

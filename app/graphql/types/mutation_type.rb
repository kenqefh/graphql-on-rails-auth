# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::Create
    field :update_user, mutation: Mutations::Users::Update
  end
end

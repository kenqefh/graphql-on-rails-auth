# frozen_string_literal: true

module Types
  class BaseObject < GraphQL::Schema::Object
    field_class Types::BaseField

    # For fields authorization, lists scoping and rules exposing
    include ActionPolicy::GraphQL::Behaviour
  end
end

# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    # For using authorization helpers in resolvers
    include ActionPolicy::GraphQL::Behaviour
  end
end

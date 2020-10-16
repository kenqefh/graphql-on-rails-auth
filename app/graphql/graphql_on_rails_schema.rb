# frozen_string_literal: true

class GraphqlOnRailsSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # Opt in to the new runtime (default in future graphql-ruby versions)
  use GraphQL::Execution::Interpreter
  use GraphQL::Analysis::AST
  # Add built-in connections for pagination
  use GraphQL::Pagination::Connections
  use GraphQL::Execution::Errors
  # Turn off introspection entry points __schema && __type
  disable_introspection_entry_points if Rails.env.production?

  # When `authorized?` returns false for an object
  def self.unauthorized_object(_error)
    raise GraphQL::ExecutionError, 'You are not authorized to perform this action'
  end

  rescue_from(ActionPolicy::Unauthorized) do |err|
    raise GraphQL::ExecutionError.new(
      # use result.message (backed by i18n) as an error message
      err.result.message,
      # use GraphQL error extensions to provide more context
      extensions: {
        code: :unauthorized,
        fullMessages: err.result.reasons.full_messages,
        details: err.result.reasons.details
      }
    )
  end
end

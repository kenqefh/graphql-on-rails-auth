module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :show_user, resolver: Queries::Users::Show
  end
end

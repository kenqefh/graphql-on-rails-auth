# frozen_string_literal: true

module Queries
  module Users
    class Show < Queries::BaseQuery
      argument :id, ID, required: true

      type Types::UserType, null: true

      def resolve(id:)
        result = ::Users::Get.call(id: id)

        if allowed_to? :show?, result.user
          result.user
        else
          raise GraphQL::ExecutionError, 'You are not allowed to view this user'
        end
      end
    end
  end
end

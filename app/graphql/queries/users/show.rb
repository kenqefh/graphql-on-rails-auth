# frozen_string_literal: true

module Queries
  module Users
    class Show < Queries::BaseQuery
      argument :id, ID, required: true

      type Types::UserType, null: true

      def resolve(id:)
        result = ::Users::Get.call(id: id)

        authorize! result.user, to: :show?

        result.user
      end
    end
  end
end

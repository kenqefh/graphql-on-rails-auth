# frozen_string_literal: true

module Queries
  module Users
    RSpec.describe Show do
      describe '.resolve' do
        it 'returns the user' do
          user = create(:user)
          variables = { id: user.id }

          result = UserApiTestSchema.execute(query, variables: variables)

          expect(result.dig('data', 'showUser')).to include(
            'email' => user.email, 'fullName' => "#{user.first_name} " + "#{user.last_name}"
          )
        end
      end

      def query
        <<~GRAPHQL
          query($id: ID!) {
            showUser(id: $id) {
              email
              fullName
            }
          }
        GRAPHQL
      end
    end
  end
end

# frozen_string_literal: true

module Queries
  module Users
    RSpec.describe Show do
      subject(:execute) do
        GraphqlOnRailsSchema.execute(query, variables: variables, context: context)
      end

      let(:user) { create(:user) }
      let(:context) { { current_user: user } }
      let(:unauthorized_user) { create(:user) }

      describe '.resolve' do
        context 'authorized' do
          let(:variables) { { id: user.id } }

          it 'returns the user' do
            data = execute.dig('data', 'showUser')

            expect(data).to include(
              'email' => user.email, 'fullName' => "#{user.first_name} " + user.last_name.to_s
            )
          end
        end

        context 'unauthorized' do
          let(:variables) { { id: unauthorized_user.id } }

          it 'fails' do
            data = execute.dig('data', 'showUser')
            error_message =  execute.dig('errors').first['message']

            expect(data).to be_nil
            expect(error_message).to eq 'You are not authorized to perform this action'
          end
        end
      end

      private

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

# frozen_string_literal: true

RSpec.describe Mutations::Users::Update, type: :request do
  subject(:execute) do
    post graphql_path,
         params: { query: query_string, variables: variables },
         headers: { 'Authorization' => "Token #{token}" }
  end

  let(:user) { create(:user) }
  let(:token) { user.generate_token }
  let(:unauthorized_user) { create(:user) }

  describe '.resolve' do
    context 'authorized' do
      context 'valid params' do
        let(:variables) { { userId: user.id, email: 'arianna@email.com' } }

        it 'updates the user' do
          execute

          json = JSON.parse(response.body)
          data = json.dig('data', 'updateUser')

          expect(data['user']).to include({ 'email' => 'arianna@email.com' })
          expect(data['errors']).to be_nil
        end
      end

      context 'invalid params' do
        let(:variables) { { userId: user.id, email: 'arianna' } }

        it 'returns an error message' do
          execute

          json = JSON.parse(response.body)
          data = json.dig('data', 'updateUser')

          expect(data['errors']).to eq ['Email is invalid']
          expect(data['user']).to be_nil
        end
      end
    end

    context 'unauthorized' do
      let(:variables) { { userId: unauthorized_user.id, email: 'arianna@email.com' } }

      it 'returns error message' do
        execute

        json = JSON.parse(response.body)

        data = json.dig('data', 'updateUser')
        error_message = json.dig('errors').first['message']

        expect(data).to be_nil
        expect(error_message).to eq 'You are not authorized to perform this action'
      end
    end

    context 'without a token' do
      let(:token) { '' }
      let(:variables) { { userId: user.id, email: 'arianna@email.com' } }

      it 'returns unauthorized status code' do
        expect(execute).to eq 401
      end
    end
  end

  def query_string
    <<~GRAPHQL
      mutation($userId: ID!, $email: String!) {
        updateUser(input: { userId: $userId, email: $email }) {
          user {
            firstName
            lastName
            email
          },
          errors
        }
      }
    GRAPHQL
  end
end

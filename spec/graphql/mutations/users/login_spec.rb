# frozen_string_literal: true

RSpec.describe Mutations::Users::Login, type: :request do
  subject(:execute) do
    post graphql_path, params: { query: query_string, variables: variables }
  end

  let(:user) { create(:user) }

  describe '.resolve' do
    context 'valid credentials' do
      let(:variables) { { email: user.email, password: user.password } }

      it 'succeeds' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'loginUser')

        expect(data['user']).not_to be_empty
        expect(data['message']).to eq 'Successfully logged in'
        expect(data['token']).not_to be_nil
      end
    end

    context 'wrong password' do
      let(:variables) { { email: user.email, password: 'wrong password' } }

      it 'fails' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'loginUser')

        expect(data['message']).to eq 'That seems like a wrong password'
        expect(data['user']).to be_nil
        expect(data['token']).to be_nil
      end
    end

    context 'email not found' do
      let(:variables) { { email: 'arianna@ari.com', password: user.password } }

      it 'fails' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'loginUser')

        expect(data['message']).to eq 'Could not find an account with that email, please sign up instead'
        expect(data['user']).to be_nil
        expect(data['token']).to be_nil
      end
    end
  end

  def query_string
    <<~GRAPHQL
      mutation($email: String!, $password: String!) {
        loginUser(input: { email: $email, password: $password }) {
          user { email },
          message
          token
        }
      }
    GRAPHQL
  end
end

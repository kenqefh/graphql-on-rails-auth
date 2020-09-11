# frozen_string_literal: true

RSpec.describe Mutations::Users::Create, type: :request do
  describe '.resolve' do
    context 'valid params' do
      it 'creates a new user' do
        expect do
          post '/graphql', params: { query: query_string, variables: variables }
        end.to change(User, :count).by 1
      end

      it 'returns the user token, and success message' do
        execute = post '/graphql', params: { query: query_string, variables: variables }

        parsed_json = JSON.parse(response.body)
        data = parsed_json['data']['createUser']

        expect(data['user']).to include(
          'fullName' => "#{variables[:firstName]} " + variables[:lastName].to_s,
          'email' => variables[:email]
        )
        expect(data['token']).not_to be_nil
        expect(data['message']).not_to be_nil
      end
    end

    context 'invalid params' do
      it 'fails' do
        execute = post '/graphql', params: { query: query_string, variables: invalid_variables }

        parsed_json = JSON.parse(response.body)
        data = parsed_json['data']['createUser']

        expect(data['errors']).to eq ['Email is invalid', "Email can't be blank"]
        expect(data['user']).to be_nil
        expect(data['message']).to be_nil
        expect(data['token']).to be_nil
      end
    end
  end

  def query_string
    <<~GRAPHQL
      mutation($firstName: String!, $lastName: String!, $email: String!, $password: String!) {
        createUser(input: {
        firstName: $firstName, lastName: $lastName, email: $email, password: $password
        }) {
          user { fullName email },
          message,
          token,
          errors
        }
      }
    GRAPHQL
  end

  def variables
    {
      firstName: 'Mac',
      lastName: 'Andre',
      email: 'mac.andre@witz.com',
      password: '#2435$52736^836w'
    }
  end

  def invalid_variables
    {
      firstName: 'Mac',
      lastName: 'Andre',
      email: '',
      password: '#2435$52736^836w'
    }
  end
end

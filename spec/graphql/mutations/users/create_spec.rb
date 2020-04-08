# frozen_string_literal: true

RSpec.describe Mutations::Users::Create, type: :request do
  describe '.resolve' do
    context 'valid params' do
      it 'creates a new user' do
        expect { 
          post '/graphql', params: { query: query_string, variables: variables }
        }.to change(User, :count).by 1
      end

      it 'returns the user object' do
        execute = post '/graphql', params: { query: query_string, variables: variables }

        parsed_json = JSON.parse(response.body)
        data = parsed_json['data']['createUser']

        expect(data['user']).to include(
          'fullName' => "#{variables[:firstName]} " + "#{variables[:lastName]}",
          'email'    => variables[:email]
        )
      end
    end

    context 'invalid params' do
      it ' returns an error message' do
        execute = post '/graphql', params: { query: query_string, variables: invalid_variables }

        parsed_json = JSON.parse(response.body)
        data = parsed_json['data']['createUser']

        expect(data.dig('errors', 'fullMessages')).to eq "[\"Email is invalid\", \"Email can't be blank\"]"
      end
    end
  end

  def query_string
    <<~GRAPHQL
      mutation($firstName: String!, $lastName: String!, $email: String!, $password: String!) {
        createUser(input: {
        firstName: $firstName, lastName: $lastName, email: $email, password: $password
        }) {
          user {
            fullName
            email
          },
          errors {
            details
            fullMessages
          }
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

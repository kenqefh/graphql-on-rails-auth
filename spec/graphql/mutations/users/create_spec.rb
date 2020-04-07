# frozen_string_literal: true

RSpec.describe Mutations::Users::Create, type: :request do
  subject(:context) do
    post '/graphql', params: { query: query_string, variables: variables }
  end

  describe '.resolve' do
    
  end

  def query_string
    <<~GRAPHQL
      mutation($firstName: String!, $lastName: String!, $email: String!, $password: String!) {
        createUser(firstName: $firstName, lastName: $lastName, email: $email, $password: String!) {
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
      firstName: Faker::Name.first_name,
      lastName: Faker::Name.last_name,
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }
  end
end

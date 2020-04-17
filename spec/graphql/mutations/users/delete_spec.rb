# frozen_string_literal: true

RSpec.describe Mutations::Users::Delete, type: :request do
  subject(:execute) do
    post graphql_path, params: { query: query_string, variables: variables }
  end

  let(:user) { create(:user) }

  describe '.resolve' do
    let(:variables) { { userId: user.id } }
     
    context 'when successful' do
      it 'deletes the user' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'deleteUser')

        binding.pry
        expect(data['message']).to eq "You have successfully deleted your account"
        expect(data['errors']).to be_nil
      end
    end
     
    context 'when it fails' do
      before do
        allow(user).to receive(:destroy!) and_return(false)
      end
       
      it 'does not delete the user' do
        execute

        json = JSON.parse(response.body)
        data = json.dig('data', 'deleteUser')

        binding.pry
        expect(data['message']).to be_nil
        expect(data['errors']).to eq ["Couldn't be destroyed"]
      end
    end
  end
  end

  def query_string
    <<~GRAPHQL
      mutation($userId: ID!) {
        deleteUser(input: { userId: $userId }) {
          message,
          errors
        }
      }
    GRAPHQL
  end
end

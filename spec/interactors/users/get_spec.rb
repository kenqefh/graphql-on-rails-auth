# frozen_string_literal: true

module Users
  RSpec.describe Get, type: :interactor do
    subject(:context) { described_class.call(id: id) }

    let(:user) { create(:user) }

    describe '.call' do
      context'when id is present' do
        let(:id) { user.id }
         
        it 'succeeds' do
          expect(context).to be_a_success
        end

        it 'returns the user' do
          expect(context.user).to be_a User
        end
      end

      context 'when id is not found' do
        let(:id) { 0 }
        let(:error_message) { ["Couldn't find User with 'id'=0"] }

        it 'fails' do
          expect(context).to be_a_failure 
        end
         
        it 'returns an error message' do
          expect(context.messages).to eq error_message
        end
      end
    end
  end
end

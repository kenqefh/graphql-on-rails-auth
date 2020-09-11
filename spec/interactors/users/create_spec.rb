# frozen_string_literal: true

module Users
  RSpec.describe Create, type: :interactor do
    subject(:sign_up) { described_class.call(attributes: attributes) }

    describe '.call' do
      context 'when given valid attributes' do
        let(:attributes) { { email: 'example@email.com', password: 'MyG00dPwd' } }

        it 'succeeds' do
          expect(sign_up).to be_a_success
        end

        it 'returns user' do
          expect(sign_up.user).to be_a User
        end

        it 'returns success message' do
          expect(sign_up.message).to eq 'You have successfully signed up'
        end

        it 'returns token' do
          expect(sign_up.token).not_to be_nil
        end
      end

      context 'when given invalid attributes' do
        let(:attributes) { { email: 'example@email.com', password: '' } }

        it 'fails' do
          expect(sign_up).to be_a_failure
        end

        it 'returns a failure message' do
          expect(sign_up.errors).to eq ["Password can't be blank"]
        end

        it 'returns nil user' do
          expect(sign_up.user).to eq nil
        end
      end
    end
  end
end

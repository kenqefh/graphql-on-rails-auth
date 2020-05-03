# frozen_string_literal: true

RSpec.describe Users::Login, type: :interactor do
  subject(:login) do
    described_class.call(credentials: credentials)
  end

  let(:user) { create(:user) }

  describe '.call' do
    context 'success' do
      let(:credentials) do
        { email: user.email, password: user.password }
      end
       
      it 'returns a success message' do
        expect(login.message).to eq 'Successfully logged in'
      end

      it 'returns the user' do
        expect(login.user).to be_a User
      end
    end

    context 'wrong password' do
      let(:credentials) do
        { email: user.email, password: 'wrong password' }
      end

      it 'returns a wrong password error message' do
        expect(login.message).to eq 'That seems like a wrong password'
      end
    end

    context 'user not found' do
      let(:credentials) do
        { email: 'one@two.com', password: user.password }
      end

      it 'returns a user not found error message' do
        expect(login.message).to eq 'Could not find an account with that email, please sign up instead'
      end
    end
  end
end

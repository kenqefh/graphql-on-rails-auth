# frozen_string_literal: true

module Users
  RSpec.describe Update, type: :interactor do
    subject(:context) { described_class.call(user: user, attributes: attributes) }

    let(:user) { create(:user) }

    context 'when attributes are valid' do
      let(:attributes) { { first_name: 'Imani', last_name: 'Alpha' } }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'updates the user' do
        expect { context; user.reload }.to change(user, :first_name).to attributes[:first_name]
      end

      it 'returns the user' do
        expect(context.user).to be_a User
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { email: '@email.com' } }
      let(:error_message) { ['Email is invalid'] }

      it 'fails' do
        expect(context).to be_a_failure
      end

      it 'returns an error message' do
        expect(context.messages).to eq error_message
      end

      it 'returns nil user' do
        expect(context.user).to be_nil
      end
    end
  end
end

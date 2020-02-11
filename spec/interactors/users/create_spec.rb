# frozen_string_literal: true

module Users
  RSpec.describe Create, type: :interactor do
    subject(:context) { described_class.call(attributes: attributes) }

    let(:attributes) { { email: 'example@email.com', password: 'MyG00dPwd' } }
    let(:user) { instance_double(User) }

    before do
      allow(User).to receive(:create).with(**attributes).and_return(user)
    end

    it 'succeeds' do
      expect(context).to be_a_success
    end

    it 'returns the user' do
      expect(context.user).to eq user
    end
  end
end

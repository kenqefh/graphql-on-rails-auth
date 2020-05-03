# frozen_string_literal: true

RSpec.describe Users::Logout, type: :interactor do
  subject(:logout) do
    described_class.call
  end

  let(:user) { create(:user) }

  describe '.call' do
    context 'success' do
      it 'returns a success message' do
        expect(logout.message).to eq 'You have logged out'
      end
    end
  end
end

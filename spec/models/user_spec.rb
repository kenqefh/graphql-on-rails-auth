# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           default(""), not null
#  first_name      :string
#  last_name       :string
#  password_digest :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_uniqueness_of :email }
  it { is_expected.to have_secure_password }

  context 'when success' do
    context 'when user has all correct attributes' do
      it 'successfully creates the user' do
        user = build(:user, email: 'example@email.com')

        result = user.save

        expect(result).to be_truthy
      end
    end
  end

  context 'when failure' do
    context 'when email format is invalid' do
      it 'does not create the user' do
        user = build(:user, email: 'example.com')

        result = user.save

        expect(result).to be_falsy
      end
    end
  end
end

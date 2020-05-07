# frozen_string_literal: true

require 'action_policy/rspec/dsl'

RSpec.describe UserPolicy, type: :policy do
  let(:user) { build_stubbed :user }
  let(:unauthorized_user) { build_stubbed :user }
  let(:record) { user }

  describe_rule :show? do
    succeed 'when user is the current user' do
      let(:context) { { user: user } }
    end

    failed 'when user is not the current user' do
      let(:context) { { user: unauthorized_user } }
    end
  end

  describe_rule :update? do
    succeed 'when user is the current user' do
      let(:context) { { user: user } }
    end

    failed 'when user is not the current user' do
      let(:context) { { user: unauthorized_user } }
    end
  end

  describe_rule :destroy? do
    succeed 'when user is the current user' do
      let(:context) { { user: user } }
    end

    failed 'when user is not the current user' do
      let(:context) { { user: unauthorized_user } }
    end
  end
end

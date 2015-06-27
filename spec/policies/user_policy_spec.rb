require 'rails_helper'

describe UserPolicy do
  let(:user) { build(:user) }
  let(:admin_user) { build(:admin_user) }

  subject { described_class }

  permissions :index? do
    it 'can see list of users if you are an admin' do
      expect(subject).to permit(admin_user, User.all)
    end

    it 'cannot see list of users if you are not an admin' do
      expect(subject).not_to permit(user, User.all)
    end
  end

  permissions :create? do
    it 'can create a user if you are an admin' do
      expect(subject).to permit(admin_user, build(:user))
    end

    it 'cannot create a user if you are not an admin' do
      expect(subject).not_to permit(user, build(:user))
    end
  end

  permissions :destroy? do
    it 'can delete a user if you are an admin' do
      expect(subject).to permit(admin_user, build(:user))
    end

    it 'cannot delete a user if you are not an admin' do
      expect(subject).not_to permit(user, build(:user))
    end
  end
end

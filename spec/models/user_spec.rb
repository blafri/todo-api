require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }

  context 'validtions' do
    it { should have_secure_password }
    it { should validate_presence_of(:user_name) }
    it { should have_many(:lists) }
  end

  context 'dependent records in lists table' do
    before do
      create(:list, user: user)
    end

    it 'should be deleted' do
      user.destroy
      expect(List.count).to eq(0)
    end
  end

  context '#admin?' do
    it 'returns true when the user is an admin' do
      expect(admin_user.admin?).to eq(true)
    end

    it 'returns false when the user is not an admin' do
      expect(user.admin?).to eq(false)
    end
  end
end

require 'rails_helper'

describe ItemPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }
  let(:item) { build(:item) }
  let(:user_item) { build(:item, list: list) }

  permissions :create? do
    it 'permits item creation if you are the item owner' do
      expect(subject).to permit(user, user_item)
    end

    it 'denies item creation if you are not the owner' do
      expect(subject).not_to permit(user, item)
    end
  end

  permissions :destroy? do
    it 'permits item deletion if you are the item owner' do
      expect(subject).to permit(user, user_item)
    end

    it 'denies item deletion if you are not the owner' do
      expect(subject).not_to permit(user, item)
    end
  end
end
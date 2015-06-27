require 'rails_helper'

describe ListPolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:list) { build(:list) }
  let(:my_list) { build(:list, user: user) }

  permissions :create? do
    it 'allows you to create a list if you are the list owner' do
      expect(subject).to permit(user, my_list)
    end

    it 'denies you to create a list if you are not the owner' do
      expect(subject).not_to permit(user, list)
    end
  end

  permissions :destroy? do
    it 'allows you to delete a list if you are the owner' do
      expect(subject).to permit(user, my_list)
    end

    it 'denies you to delete a list you do not own' do
      expect(subject).not_to permit(user, list)
    end
  end
end
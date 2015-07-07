require 'rails_helper'

describe ListPolicy do
  subject { described_class }

  let(:user) { build(:user) }
  let(:list) { build(:list) }
  let(:my_list) { build(:list, user: user) }

  permissions ".scope" do
    before do
      user.save
      list.save
      my_list.save
    end

    it 'only shows my lists' do
      lists = Pundit.policy_scope!(user, List)

      expect(lists.count).to eq(1)
      expect(lists.first.name).to eq(my_list.name)
    end
  end

  permissions :index? do
    it 'allows me to see an index of my lists if I am logged in' do
      expect(subject).to permit(user)
    end

    it 'denies me to see an index of my lists if I am not logged in' do
      expect(subject).not_to permit(nil)
    end
  end

  permissions :show? do
    it 'allows me to view my own list' do
      my_list.save
      expect(subject).to permit(user, my_list)
    end

    it 'denies me to view someone elses list' do
      list.save
      expect(subject).not_to permit(user, list)
    end
  end

  permissions :create? do
    it 'allows you to create a list if you are the list owner' do
      expect(subject).to permit(user, my_list)
    end

    it 'denies you to create a list if you are not the owner' do
      expect(subject).not_to permit(user, list)
    end
  end

  permissions :update? do
    it 'allows a user to update a list if he owns the list' do
      expect(subject).to permit(user, my_list)
    end

    it 'denies a user to update a list if he does not own the list' do
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
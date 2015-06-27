require 'rails_helper'

RSpec.describe List, type: :model do
  let(:user) { create(:user) }
  let(:list) { create(:list) }

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user) }
    it { should belong_to(:user) }
    it { should have_many(:items) }
  end

  context 'dependent records in items table' do
    before do
      create(:item, list: list)
    end

    it 'should be deleted' do
      list.destroy
      expect(Item.count).to eq(0)
    end
  end

  context '::lists_for' do
    before do
      create(:list, user: user)
      create(:list)
      create(:list)
    end

    it 'should only return lists that belong to the user' do
      expect(List.lists_for(user).count).to eq(1)
    end
  end
end

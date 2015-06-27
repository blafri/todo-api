require 'rails_helper'

RSpec.describe List, type: :model do
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
end

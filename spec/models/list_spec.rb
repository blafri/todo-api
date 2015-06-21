require 'rails_helper'

RSpec.describe List, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:user) }
    it { should belong_to(:user) }
    it { should have_many(:items) }
  end
end

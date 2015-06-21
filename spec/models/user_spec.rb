require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validtions' do
    it { should have_secure_password }
    it { should validate_presence_of(:user_name) }
    it { should have_many(:lists) }
  end
end

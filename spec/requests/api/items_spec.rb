require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }

  context 'with authentication' do
    before do
      http_login(user.user_name, user.password)
    end

    it 'items can be created successfully' do
      item = { item: { name: 'test item' } }
      post api_list_items_path(list), item, @env

      expect(list.items.first.name).to eq('test item')
      expect(response).to have_http_status(201)
      expect(json_response['item']['name']).to eq('test item')
    end
  end

  context 'without authentication' do
    it 'item fails to be created' do
      item = { item: { name: 'test item' } }
      post api_list_items_path(list), item

      expect(response).to have_http_status(401)
    end
  end
end

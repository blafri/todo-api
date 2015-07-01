require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }
  let(:my_item) { create(:item, list: list) }
  let(:item) { create(:item) }

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

    context 'delete items' do
      it 'is successful if you are the owner' do
        delete api_item_path(my_item), {}, @env

        expect(list.items.count).to eq(0)
        expect(response).to have_http_status(204)
      end

      it 'is unsuccessful if you are not the owner' do
        delete api_item_path(item), {}, @env

        expect(Item.where(id: item.id).empty?).to eq(false)
        expect(response).to have_http_status(403)
      end
    end

    context 'update items' do
      it 'is successful if you are the owner' do
        item_update = { item: { completed: true } }
        patch api_item_path(my_item), item_update, @env

        expect(Item.first.completed).to eq(true)
        expect(response).to have_http_status(200)
        expect(json_response['item']['completed']).to eq(true)
      end

      it 'is unsuccessful if you are not the owner' do
        item_update = { item: { completed: true } }
        patch api_item_path(item), item_update, @env

        expect(response).to have_http_status(403)
      end
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

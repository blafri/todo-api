require 'rails_helper'

RSpec.describe 'Lists', type: :request do
  let(:user) { create(:user) }
  let(:my_list) { create(:list, user: user) }
  let(:list) { create(:list) }

  context 'with authentication' do
    before do
      http_login(user.user_name, user.password)
    end

    it 'lists can be created successfully' do
      list = { list: { name: 'test list' } }
      post api_lists_path, list, @env

      expect(user.lists.first.name).to eq('test list')
      expect(response).to have_http_status(201)
      expect(json_response['list']['name']).to eq('test list')
    end

    context 'delete lists' do
      it 'is successful if the user owns the list' do
        list = create(:list, user: user)
        delete api_list_path(list), {}, @env

        expect(user.lists.count).to eq(0)
        expect(response).to have_http_status(204)
      end

      it 'is unsuccessful if the user does not own the list' do
        list = create(:list)
        delete api_list_path(list), {}, @env

        expect(List.where(id: list.id).empty?).to eq(false)
        expect(response).to have_http_status(403)
      end
    end

    context 'index of user\'s lists' do
      before do
        my_list
        list
      end

      it 'user\' list index only shows their lists' do
        get api_lists_path, {}, @env

        expect(response).to have_http_status(200)
        expect(json_response['lists'].count).to eq(1)
      end
    end

    context 'show a list' do
      it 'is successful if the user owns the list' do
        get api_list_path(my_list), {}, @env

        expect(response).to have_http_status(200)
        expect(json_response['list']['id']).to eq(my_list.id)
      end

      it 'is unsuccessful if the user does not own the list' do
        get api_list_path(list), {}, @env

        expect(response).to have_http_status(403)
      end
    end

    context 'update a list' do
      it 'is successful if the user owns the list' do
        list_update = { list: { name: 'new list name' } }
        patch api_list_path(my_list), list_update, @env

        expect(List.first.name).to eq('new list name')
        expect(response).to have_http_status(200)
        expect(json_response['list']['name']).to eq('new list name')
      end

      it 'is unsuccessful if the user does not own the list' do
        list_update = { list: { name: 'new list name' } }
        patch api_list_path(list), list_update, @env

        expect(response).to have_http_status(403)
      end

      it 'is unsuccessful if invalid value for permission' do
        list_update = { list: { permission: 'invalid_value' } }
        patch api_list_path(my_list), list_update, @env

        expect(response).to have_http_status(422)
      end
    end
  end

  context 'without authentication' do
    it 'list fails to be created' do
      list = { list: { name: 'test list' } }
      post api_lists_path(user), list

      expect(response).to have_http_status(401)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Lists', type: :request do
  let(:user) { create(:user) }

  context 'with authentication' do
    before do
      http_login(user.user_name, user.password)
    end

    it 'lists can be created successfully' do
      list = { list: { name: 'test list' } }
      post api_user_lists_path(user), list, @env

      expect(user.lists.first.name).to eq('test list')
      expect(response).to have_http_status(201)
      expect(json_response['list']['name']).to eq('test list')
    end
  end

  context 'without authentication' do
    it 'list fails to be created' do
      list = { list: { name: 'test list' } }
      post api_user_lists_path(user), list

      expect(response).to have_http_status(401)
    end
  end
end

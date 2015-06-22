require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

  context 'with authentication' do

    before do
      http_login(user.user_name, user.password)
    end

    it 'can generate a list of users' do
      get api_users_path, {}, @env

      expect(response).to have_http_status(200)
      expect(json_response['users'].count).to eq(1)
      expect(json_response['users'][0]['id']).to eq(user.id)
    end

    it 'cannot create a user with a duplicate user name' do
      user_to_create = { user: { user_name: user.user_name, password: 'test' } }
      post api_users_path, user_to_create, @env

      expect(User.count).to eq(1)
      expect(response).to have_http_status(422)
      expect(json_response['errors'][0]).to eq('User name has already been taken')
    end

    it 'can create a user' do
      user_to_create = { user: { user_name: 'test', password: 'test' } }
      post api_users_path, user_to_create, @env

      expect(User.find_by_user_name('test')).not_to eq(nil)
      expect(response).to have_http_status(201)
      expect(json_response['user']['user_name']).to eq('test')
    end
  end

  context 'without authentication' do
    it 'fails with a 401 unathorized error' do
      get api_users_path

      expect(response).to have_http_status(401)
    end
  end
end

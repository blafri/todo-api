require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }

  context 'with authentication' do
    context 'when an admin' do
      before do
        http_login(admin_user.user_name, admin_user.password)
      end

      it 'can generate a list of users' do
        get api_users_path, {}, @env

        expect(response).to have_http_status(200)
        expect(json_response['users'].count).to eq(1)
        expect(json_response['users'][0]['id']).to eq(admin_user.id)
      end

      it 'cannot create a user with a duplicate user name' do
        user_to_create = { user: { user_name: admin_user.user_name, password: 'test' } }
        post api_users_path, user_to_create, @env

        expect(User.count).to eq(1)
        expect(response).to have_http_status(422)
        expect(json_response['errors'][0]).to eq('User name has already been taken')
      end

      it 'can create a new user' do
        user_to_create = { user: { user_name: 'test', password: 'test' } }
        post api_users_path, user_to_create, @env

        expect(User.find_by_user_name('test')).not_to eq(nil)
        expect(response).to have_http_status(201)
        expect(json_response['user']['user_name']).to eq('test')
      end

      it 'can delete a user' do
        user2 = create(:user)
        delete api_user_path(user2), {}, @env

        expect(User.count).to eq(1)
        expect(response).to have_http_status(204)
      end
    end

    context 'when a normal user' do
      before do
        http_login(user.user_name, user.password)
      end

      it 'cannot get the index of users' do
        get api_users_path, {}, @env

        expect(response).to have_http_status(403)
      end

      it 'cannot create a new user' do
        user_to_create = { user: { user_name: 'test', password: 'test' } }
        post api_users_path, user_to_create, @env

        expect(User.count).to eq(1)
        expect(response).to have_http_status(403)
      end

      it 'cannot delete a user' do
        user2 = create(:user)
        delete api_user_path(user2), {}, @env

        expect(User.where(id: user2.id).empty?).to eq(false)
        expect(response).to have_http_status(403)
      end
    end
  end

  context 'without authentication' do
    it 'fails with a 401 unathorized error' do
      get api_users_path

      expect(response).to have_http_status(401)
    end
  end
end

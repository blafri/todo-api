require 'rails_helper'

RSpec.describe 'Users', :type => :request do
  let(:user) { create(:user) }

  context 'with authentication' do

    before do
      http_login(user.user_name, user.password)
    end

    it 'can generate a list of users' do
      get api_users_path, {}, @env

      expect(response).to have_http_status(200)
    end
  end

  context 'without authentication' do
    it 'fails with a 401 unathorized error' do
      get api_users_path

      expect(response).to have_http_status(401)
    end
  end
end

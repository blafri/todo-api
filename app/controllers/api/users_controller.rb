module Api
  # Public: Users controller
  class UsersController < Api::BaseController
    before_action :authenticated?

    def index
      render json: users_list
    end

    private

    def users_list
      User.all
    end
  end
end

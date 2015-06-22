module Api
  # Public: Users controller
  class UsersController < Api::BaseController
    before_action :authenticated?

    def index
      render json: User.all
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:user_name, :password)
    end
  end
end

module Api
  # Public: Users controller
  class UsersController < Api::BaseController
    after_action :verify_authorized

    def index
      authorize current_user
      render json: User.all
    end

    def create
      user = User.new(user_params)
      authorize user

      if user.save
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
      user = User.find(params[:id])
      authorize user

      if user.destroy
        destroy_successful
      else
        destroy_error
      end
    end

    private

    # Iternal: Permits parameters that the user is allowed to set
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
  end
end

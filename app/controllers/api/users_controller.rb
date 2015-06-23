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

    def destroy
      user = User.find(params[:id])

      if user.destroy
        destroy_successful
      else
        destroy_error
      end

    rescue ActiveRecord::RecordNotFound
      object_not_found
    end

    private

    # Iternal: Permits parameters that the user is allowed to set
    def user_params
      params.require(:user).permit(:user_name, :password)
    end
  end
end

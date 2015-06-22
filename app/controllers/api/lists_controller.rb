module Api
  # Public: lists controller
  class ListsController < Api::BaseController
    before_action :authenticated?
    before_action :url_args

    def create
      list = @user.lists.build(list_params)
      if list.save
        render json: list, status: :created
      else
        render json: { errors: list.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    private

    # Internal: Sets instance variables for parameters passed in the URI string
    def url_args
      @user = User.find(params[:user_id]) if params.include?(:user_id)
      @list = List.find(params[:id]) if params.include?(:id)
    end

    def list_params
      params.require(:list).permit(:name)
    end
  end
end

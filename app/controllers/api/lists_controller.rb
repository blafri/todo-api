module Api
  # Public: lists controller
  class ListsController < Api::BaseController
    before_action :authenticated?

    after_action :verify_authorized

    def create
      list = current_user.lists.build(list_params)
      authorize list

      if list.save
        render json: list, status: :created
      else
        render json: { errors: list.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
      list = List.find(params[:id])
      authorize list

      if list.destroy
        destroy_successful
      else
        destroy_error
      end
    end

    private

    # Iternal: Permits parameters that the user is allowed to set
    def list_params
      params.require(:list).permit(:name)
    end
  end
end

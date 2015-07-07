module Api
  # Public: lists controller
  class ListsController < Api::BaseController
    after_action :verify_authorized

    def index
      lists = List.lists_for(current_user)
      authorize lists

      render json: lists, no_associations: true
    end

    def show
      authorize list
      render json: list
    end

    def create
      new_list = current_user.lists.build(list_params)
      authorize new_list

      if new_list.save
        render json: new_list, status: :created
      else
        render json: { errors: new_list.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      authorize list

      if list.update_attributes(list_params)
        render json: list
      else
        render json: { errors: list.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
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
      params.require(:list).permit(:name, :permission)
    end

    def list
      @list ||= List.find(params[:id])
    end
  end
end

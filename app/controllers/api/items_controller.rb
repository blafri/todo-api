module Api
  # Public: items controller
  class ItemsController < Api::BaseController
    after_action :verify_authorized

    def create
      item = current_user.lists.find(params[:list_id]).items.build(item_params)
      authorize item

      if item.save
        render json: item, status: :created
      else
        render json: { errors: item.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
      item = Item.find(params[:id])
      authorize item

      if item.destroy
        destroy_successful
      else
        destroy_error
      end
    end

    private

    # Iternal: Permits parameters that the user is allowed to set
    def item_params
      params.require(:item).permit(:name)
    end
  end
end

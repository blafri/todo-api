module Api
  # Public: items controller
  class ItemsController < Api::BaseController
    after_action :verify_authorized

    def create
      new_item = current_user.lists.find(params[:list_id])
                   .items.build(item_params)
      authorize new_item

      if new_item.save
        render json: new_item, status: :created
      else
        render json: { errors: new_item.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def update
      authorize item

      if item.update_attributes(item_params)
        render json: item
      else
        render json: { errors: item.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
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
      params.require(:item).permit(:name, :completed)
    end

    def item
      @item ||= Item.find(params[:id])
    end
  end
end

module Api
  # Public: items controller
  class ItemsController < Api::BaseController
    before_action :authenticated?
    before_action :url_args

    def create
      item = @list.items.build(item_params)
      if item.save
        render json: item, status: :created
      else
        render json: { errors: item.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def destroy
      if @item.destroy
        destroy_successful
      else
        destroy_error
      end
    end

    private

    # Internal: Sets instance variables for parameters passed in the URI string
    def url_args
      @list = List.find(params[:list_id]) if params.include?(:list_id)
      @item = Item.find(params[:id]) if params.include?(:id)

    rescue ActiveRecord::RecordNotFound
      object_not_found
    end

    # Iternal: Permits parameters that the user is allowed to set
    def item_params
      params.require(:item).permit(:name)
    end
  end
end

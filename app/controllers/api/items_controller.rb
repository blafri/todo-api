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

    private

    # Internal: Sets instance variables for parameters passed in the URI string
    def url_args
      @list = List.find(params[:list_id]) if params.include?(:list_id)
      @item = Item.find(params[:id]) if params.include?(:id)
    end

    def item_params
      params.require(:item).permit(:name)
    end
  end
end

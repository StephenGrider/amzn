class LineItemsController < ApplicationController
  def index
    @line_items = LineItem.paginate(:page => params[:page])
  end
  
  def create
    LineItem.create(user_id: current_user.id, item_id: params[:item_id])
    render :nothing => true
  end
  
  def destroy
    line_item = LineItem.find(params[:id])
    if line_item.can_destroy?(current_user)
      line_item.destroy
    end
    
    render :nothing => true
  end
end

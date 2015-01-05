class LineItemsController < ApplicationController
  def index
    @line_items = LineItem.all
  end
  
  def create
    LineItem.create(user_id: current_user.id, item_id: params[:item_id])
    render :nothing => true
  end
end

class LineItemsController < ApplicationController
  def index
    @line_items = LineItem.paginate(:page => params[:page])
  end
end

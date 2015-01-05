class LineItemsController < ApplicationController
  def index
    @line_items = LineItem.all
  end
  
  def create
  end
end

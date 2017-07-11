class ItemsController < ApplicationController


  def show
    @item = Item.find_by(params[:id])
  end

end

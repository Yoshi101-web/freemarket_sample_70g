class Items::SearchesController < ApplicationController
  def index
    @items = Item.search(params[:keyword])
    @page = @items.page(params[:page]).per(20)
    @category = Category.all.order("ancestry ASC").limit(13)
    @parents = Category.where(ancestry:nil)
    @q = Item.ransack(params[:q])
    @items_ransack = @q.result(distinct: true)
  end
end

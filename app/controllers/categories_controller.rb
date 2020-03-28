class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @categories = @category.items.page(params[:page]).per(20)
    @category_children = @category.children
    @items = Item.includes(:images).order(:item_purchaser_id, "id DESC")
    @parents = Category.where(ancestry:nil)
  end
end
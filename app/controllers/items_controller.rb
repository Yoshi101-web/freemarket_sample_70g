class ItemsController < ApplicationController
  before_action :set_item, only: [:confirm, :show, :edit, :update]
  before_action :set_category, only: [:index, :new, :create, :show, :edit]
  before_action :set_category_parent, only: [:index, :show]
  before_action :set_items_image, only: [:index, :show]



  def index
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @item.images.build
      render :new
    end
  end

  def confirm
    @location = current_user.location
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user).order("id DESC")
  end

  def category_children
    @category_children = Category.find(params[:productcategory]).children
  end

  # Ajax通信で送られてきたデータをparamsで受け取り､childrenで子を取得
  def category_grandchildren
    @category_grandchildren = Category.find(params[:productcategory]).children
  end

  def search
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  def edit
    @selected_grandchild_category = @item.category
    @selected_child_category = @selected_grandchild_category.parent
    @selected_parent_category = @selected_child_category.parent
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    redirect_to user_path(current_user.id) and return unless item.destroy
    redirect_to onsale_user_path(current_user.id)
  end

  def search
    @items = Item.search(params[:keyword])
  end


  private
  def item_params
    params.require(:item).permit(:item_name, :description, :category_id, :brand_name, :size, :condition,
                                  :shipping_fee_payer,:prefecture_id, :shipping_days, :price,
                                  images_attributes: [:image, :_destroy, :id], categories_attributes: [:name]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.includes(:user).find(params[:id])
  end

  def user_params
    params.require(:item).permit(user:[:nickname])
  end

  def set_category
    @category = Category.all.order("ancestry ASC").limit(13)
  end

  def set_category_parent
    @parents = Category.where(ancestry:nil)
  end

  def set_items_image
    @items = Item.includes(:images).order(:item_purchaser_id, "id DESC")
  end

end
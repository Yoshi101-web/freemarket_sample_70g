class UsersController < ApplicationController
  before_action :set_profile, only: [:profile_edit, :profile_update]
  before_action :set_location, only: [:location_edit, :location_update]
  before_action :set_header, only: [:show, :onsale, :done, :bought, :like, :location_edit, :profile_edit]
  before_action :set_item, only: [:onsale, :done, :bought, :like]




  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def onsale
  end

  def done
  end

  def bought
  end

  def like
  end

  def location_edit
  end

  def location_update
    @location.update(location_params)
    redirect_to user_path
  end

  def profile_edit
  end

  def profile_update
    @user.update(user_params)
    redirect_to user_path
  end


  private
  def set_profile
    @user = User.find(params[:id])
  end

  def set_location
    @location = current_user.location
  end

  def set_header
    @items = Item.includes(:images).order(:item_purchaser_id, "id DESC")
    @category = Category.all.order("ancestry ASC").limit(13)
    @parents = Category.where(ancestry:nil)
  end

  def user_params
    params.require(:user).permit(:user_family_name, :user_first_name, :user_family_name_kana, :user_first_name_kana, :birth, :introduction, :user_image)
  end

  def location_params
    params.require(:location).permit(:family_name, :first_name, :family_name_kana, :first_name_kana, :postal_code, :prefecture, :city, :building_name, :phone_name)
  end

  def set_item
    @items = Item.includes(:user)
  end

end

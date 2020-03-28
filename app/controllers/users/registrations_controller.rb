# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  # GET /resource/sign_up
  def new
    @user = User.new
  end
  
  # POST /resource@
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"]= params[:user][:password]
    @location = @user.build_location
    render :new_location
  end

  def create_location
    @user = User.new(session["devise.regist_data"]["user"])
    @location = Location.new(location_params)
    unless @location.valid?
      flash.now[:alert] = @location.errors.full_messages
      render :new_location and return
    end 
    @user.build_location(@location.attributes)
    if @user.save
      sign_in(:user, @user)
    else
      flash.now[:error] = 'ユーザー情報の保存に失敗しました'
      render :create
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute,:user_family_name,:user_first_name,:user_family_name_kana,:user_first_name_kana,:birth])
  end

  def location_params
    params.require(:location).permit(:family_name,:first_name,:family_name_kana,:first_name_kana,:postal_code, :prefecture,:city,:building_name,:phone_name)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # 
  
end

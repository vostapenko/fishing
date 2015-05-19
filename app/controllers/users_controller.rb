class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless @user.activated
  end

  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)
     if @user.save
       @user.send_activation_email
       flash[:info] = "Инструкции по активации учётной записи отправлены на Ваш почтовый адрес"
       redirect_to login_url
     else
       render 'new'
     end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Ваш профиль успешно обновлён."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удалён"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Необходимо войти на сайт."
      redirect_to login_url
    end
  end

 def correct_user
   @user = User.find(params[:id])
   redirect_to(current_user) unless current_user?(@user)
 end

end

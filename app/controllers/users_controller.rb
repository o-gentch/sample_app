class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account." 
      redirect_to root_url
    else 
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy 
    flash[:success] = "User deleted" 
    redirect_to users_url
  end
  
  def edit
  end

  def update
    @user.update(user_params)
    if @user.errors.empty? 
      flash[:success] = "Profile updated, buddy!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 

    # Предварительные фильтры
    
    # Подтверждает наличие прав администратора

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # Подтверждает права пользователя.
    def correct_user
      @user = User.find(params[:id]) 
      redirect_to(root_url) unless current_user?(@user)
    end

end

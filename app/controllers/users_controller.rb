class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :new, :create]
  before_action :edit_permission, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :new]
  def new
    @user = User.new
  end
  def show
    @user = User.find params[:id]
  end
  def create
    @user = User.new user_params 
    if @user.save
      
      flash[:success] = "Success add new trainee"
      redirect_to @user
    else
      #unsuccess
      render 'new'
    end
  end
  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      #handle a successful update.
      flash[:success] = "profile updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def edit
    @user = User.find params[:id] 
  end
  def index
    @users = User.paginate page: params[:page]
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end





  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                        :password_confirmation)
    end
    #before filter
    #confirm logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "please log in"
        redirect_to login_url
      end
    end
    # #confirm correct user
    # def correct_user
    #   @user = User.find params[:id] 
    #   redirect_to root_url if !current_user? @user
    # end
    #confirm admin user
    def admin_user
      redirect_to root_url if !current_user.supervisor?
    end
    def edit_permission
      @user = User.find params[:id]
      if !(current_user?(@user) || current_user.supervisor?)
        redirect_to root_url
      end
    end
end

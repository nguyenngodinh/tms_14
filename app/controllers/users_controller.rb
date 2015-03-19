class UsersController < ApplicationController
  include UsersHelper
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy, :new, :create]
  before_action :edit_permission, only: [:edit, :update]
  before_action :supervisor_user, only: [:destroy, :new, :index]
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
      render 'new'
    end
  end
  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
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
    @trainees = User.trainees.paginate(page: params[:page])
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  private
    def user_params
      params.require(:user).permit :name, :email, :password,
                                        :password_confirmation
    end
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "please log in"
        redirect_to login_url
      end
    end
    def edit_permission
      @user = User.find params[:id]
      if !current_user?(@user) || current_user.supervisor?
        redirect_to root_url
      end
    end
end

class SubjectsController < ApplicationController
  include UsersHelper
  before_action :supervisor_user, only: [:destroy, :new, :index]
  def new
    @subject = Subject.new
  end
  def show
    @subject = Subject.find params[:id]
  end
  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = "create new subject successful!"
      redirect_to @subject
    else
      render 'new'
    end
  end
  def edit
    @subject = Subject.find params[:id]
  end
  def update
    @subject = Subject.find params[:id]
    if @subject.update_attributes subject_params
      flash[:success] = "update subject info successful"
      redirect_to @subject
    else
      render 'edit'
    end
  end
  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def destroy
    Subject.find(params[:id]).destroy
    flash[:success] = "Subject deleted"
    redirect_to subjects_url
  end
  private
    def subject_params
      params.require(:subject).permit :name, :info
    end
end

class CoursesController < ApplicationController

  def show
    @course = Course.find params[:id]   
  end

  def new
    @course = Course.new
  end

  def index
    @courses = Course.all
  end

  def destroy
    Course.find params[:id] .destroy
    flash[:success] = "Course deleted"
    redirect_to courses_url
  end

  def create
    @course = Course.new course_params
    if @course.save      
      flash[:info] = "Successful!"
      redirect_to courses_url
    else
      render 'new'
    end
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    if @course.update_attributes course_params
      flash[:success] = "Successful!"
      redirect_to @course
    else
      render 'edit'
    end
  end
  
  private
    def course_params
      params.require(:course).permit :name, :content
    end
end


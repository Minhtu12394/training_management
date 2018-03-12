class CoursesController < ApplicationController
  before_action :find_course, only: [:show, :update]

  def index
    @courses = Course.all.order(:course_name).paginate(page: params[:page], per_page: Settings.page.maximum)
  end

  def new
    @course = Course.new
    Subject.all.each do |subject|
      @course.course_subjects.new subject: subject
    end
  end

  def create
    @course = Course.new course_params

    if @course.save
      flash[:success] = (t ".success")
      redirect_to course_url @course
    else
      redirect_to root_path
    end
  end

  def update
  end

  def show
    @course = Course.find_by id: params[:id]
  end

  def destroy
  	
  end

  private

  def find_course
    @course = Course.find_by id: params[:id]
    return if @course
      flash[:warning] = t ".not_found"
      redirect_to new_course_path
  end

  def course_params
    params.require(:course).permit :course_name, :start_date, :end_date,
                                   course_subjects_attributes: [:id, :subject_id, :_destroy]
  end
end

class CoursesController < ApplicationController
  before_action :find_course, only: [:show, :edit, :update, :destroy]
  before_action :new_course, only: [:create]

  def index
    @courses = current_user.courses
  end

  def show
    raise unless current_user.courses.include? @course
    @course_data = @course.timeseries
    @user_data = @course.timeseries_by_user current_user
    if @user_data.length > 0
      lastdate = @course_data.last[0]
      @user_data << [lastdate, @user_data.last[1]]
    end
  end

  def new
    raise unless current_user.is_professor
    @course = Course.new
  end

  def edit
    raise unless current_user.teaches? @course
  end

  def create
    raise unless current_user.is_professor
    if @course.save
      Registration.create! user: current_user, course: @course, role: 'INSTRUCTOR'
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render :new
    end
  end

  def update
    raise unless (current_user.is_professor && current_user.teaches?(@course))
    if @course.update(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    raise unless (current_user.is_professor && current_user.teaches?(@course))
    @course.destroy
    redirect_to courses_url, notice: 'Course was successfully destroyed.' 
  end

  private
    def find_course
      @course = Course.find(params[:id])
    end

    def new_course
      @course = Course.new(course_params)
    end

    def course_params
      params.require(:course).permit(:year, :semester, :name)
    end
end

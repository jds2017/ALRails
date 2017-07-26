class CoursesController < ApplicationController
  before_action :find_course, only: [:show, :edit, :update, :destroy]
  before_action :new_course, only: [:create]

  def index
    @courses = current_user.courses
  end

  def show
    @course_data = @course.timeseries
    @user_data = @course.timeseries_by_user current_user
    if @user_data.length > 0
      lastdate = @course_data.last[0]
      @user_data << [lastdate, @user_data.last[1]]
    end
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @course.save
        if current_user.is_professor
          Registration.create! user: current_user, course: @course, role: 'INSTRUCTOR'
        end
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
    end
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

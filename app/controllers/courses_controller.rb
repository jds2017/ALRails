class CoursesController < ApplicationController
  before_action :find_course, only: [:show, :edit, :update, :destroy]
  before_action :new_course, only: [:create]
  before_action :validate_read, only: [:show, :edit]
  before_action :validate_modify, only: [:create, :destroy, :update]

  # GET /courses
  # GET /courses.json
  def index
    if current_user.is_admin
      @courses = Course.all
    else
      @courses = current_user.courses
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @lecture_ids = CourseToLectureJunction.where(course: @course)
    @lectures = []
    @lecture_ids.each do |clj|
      @lectures.push(Lecture.find(clj.lecture_id))
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    respond_to do |format|
      if @course.save
        if current_user.is_professor
          Registration.create! user: current_user, course: @course, role: 'ASSISTANT'
        end
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def validate_read
      raise unless current_user.is_admin || current_user.courses.include?(@course)
    end

    def validate_modify
      raise unless current_user.is_admin || current_user.is_professor
    end

    # Use callbacks to share common setup or constraints between actions.
    def find_course
      @course = Course.find(params[:id])
    end

    def new_course
      @course = Course.new(course_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:year, :semester, :name)
    end
end

class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :validate_is_prof, only: [:create]
  before_action :validate_is_owner, only: [:edit, :update, :destroy]
  before_action :validate_is_registered, only: [:show]

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
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
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
    def validate_is_prof
      if !current_user.is_admin and !current_user.is_professor
        raise
      end
    end

    def validate_is_owner
      if !current_user.courses_as_professor.include?(@course) && !current_user.courses_as_assistant.include?(@course)
        raise
      end
    end

    def validate_is_registered
      if !current_user.courses.include? @course
        raise
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:year, :semester, :name, :student_key)
    end
end

class CourseToLectureJunctionsController < ApplicationController
  before_action :set_course_to_lecture_junction, only: [:show, :edit, :update, :destroy]

  # GET /course_to_lecture_junctions
  # GET /course_to_lecture_junctions.json
  def index
    @course_to_lecture_junctions = CourseToLectureJunction.all
  end

  # GET /course_to_lecture_junctions/1
  # GET /course_to_lecture_junctions/1.json
  def show
  end

  # GET /course_to_lecture_junctions/new
  def new
    @course_to_lecture_junction = CourseToLectureJunction.new
  end

  # GET /course_to_lecture_junctions/1/edit
  def edit
  end

  # POST /course_to_lecture_junctions
  # POST /course_to_lecture_junctions.json
  def create
    @course_to_lecture_junction = CourseToLectureJunction.new(course_to_lecture_junction_params)

    respond_to do |format|
      if @course_to_lecture_junction.save
        format.html { redirect_to @course_to_lecture_junction, notice: 'Course to lecture junction was successfully created.' }
        format.json { render :show, status: :created, location: @course_to_lecture_junction }
      else
        format.html { render :new }
        format.json { render json: @course_to_lecture_junction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_to_lecture_junctions/1
  # PATCH/PUT /course_to_lecture_junctions/1.json
  def update
    respond_to do |format|
      if @course_to_lecture_junction.update(course_to_lecture_junction_params)
        format.html { redirect_to @course_to_lecture_junction, notice: 'Course to lecture junction was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_to_lecture_junction }
      else
        format.html { render :edit }
        format.json { render json: @course_to_lecture_junction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_to_lecture_junctions/1
  # DELETE /course_to_lecture_junctions/1.json
  def destroy
    @course_to_lecture_junction.destroy
    respond_to do |format|
      format.html { redirect_to course_to_lecture_junctions_url, notice: 'Course to lecture junction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_to_lecture_junction
      @course_to_lecture_junction = CourseToLectureJunction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_to_lecture_junction_params
      params.require(:course_to_lecture_junction).permit(:course_id, :lecture_id)
    end
end

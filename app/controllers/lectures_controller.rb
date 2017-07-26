require 'uri'

class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  def index
    @lectures = Lecture.all
  end

  def show
    @response_averages = @lecture.response_average
    responses = Response.where(lecture: @lecture, user: current_user)
    @emoji_map = responses.map { |res| [res.answer, (res.is_correct? ? '✅' : '✖')]}.to_h
    @livelecture_uri = URI.encode "/livelecture/show?lecture=#{params[:id]}"
  end

  def new
    @lecture = Lecture.new
  end

  def edit
  end

  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.question_set = @lecture.question_set.readonly_copy
    respond_to do |format|
      if @lecture.save
        # find new lecture_id and course_id, then add to junction table
        @clj = CourseToLectureJunction.new(:course_id => params[:course_id], :lecture_id => @lecture.id)
        @clj.save
        if @course.nil?
            format.html { redirect_to @lecture, notice: 'Lecture was successfully created.'}
            format.json { render :show, status: :created, location: @lecture}
        else
            format.html { redirect_to @course, notice: 'Lecture was successfully created.'}
            format.json { render :show, status: :created, location: @course}      
        end
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    def set_course
      @course = Course.find_by(id: params[:course_id])
    end

    def lecture_params
      params.require(:lecture).permit(:title, :date_of_use, :question_set_id)
    end
end

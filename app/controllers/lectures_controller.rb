require 'uri'

class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy]

  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = Lecture.all
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @livelecture_uri = URI.encode "/livelecture/show?lecture=#{params[:id]}"
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
    @course_id = params[:course_id]
  end

  # GET /lectures/1/edit
  def edit
  end

  # POST /lectures
  # POST /lectures.json
  def create
    question_set = QuestionSet.find(lecture_params['question_set_id'])
    new_question_set = QuestionSet.create!(name: question_set.name + ' (clone)', is_readonly: true)
    question_set.questions.each do |q|
      new_question_set.questions << q
    end
    @lecture = Lecture.new(lecture_params)
    @lecture.question_set = new_question_set

    respond_to do |format|
      if @lecture.save
        # find new lecture_id and course_id, then add to junction table
        @clj = CourseToLectureJunction.new(:course_id => params[:course_id], :lecture_id => @lecture.id)
        @clj.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
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

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to lectures_url, notice: 'Lecture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:title, :date_of_use, :question_set_id)
    end
end

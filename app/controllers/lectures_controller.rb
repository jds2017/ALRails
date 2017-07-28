require 'uri'

class LecturesController < ApplicationController
  before_action :set_lecture, only: [:show, :edit, :update, :destroy]
  before_action :set_course

  def show
    raise unless current_user.courses.include? @lecture.course
    @response_averages = @lecture.response_average
    responses = Response.where(lecture: @lecture, user: current_user)
    @emoji_map = responses.map { |res| [res.answer, (res.is_correct? ? '✅' : '✖')]}.to_h
    @livelecture_uri = URI.encode "/livelecture/show?lecture=#{params[:id]}"
  end

  def new
    @lecture = Lecture.new
  end

  def edit
    raise unless current_user.courses.include? @lecture.course
  end

  def create
    raise unless current_user.teaches? @course
    @lecture = Lecture.new(lecture_params)
    @lecture.question_set = @lecture.question_set.readonly_copy
    @lecture.course = @course
    @course.lectures.push @lecture
    if @lecture.save
      redirect_to @course, notice: 'Lecture was successfully created.'
    else
      render :new
    end
  end

  def update
    raise unless current_user.teaches? @course
    if @lecture.update(lecture_params)
      redirect_to @lecture, notice: 'Lecture was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    raise unless current_user.teaches? @course
    @lecture.destroy
    redirect_to lectures_url, notice: 'Lecture was successfully destroyed.'
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

class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]

  def index
    @names = current_user.courses_as_instructor.map { |c| c.name }.uniq
  end

  def show
    raise unless teaches_set
  end

  def new
    raise unless current_user.courses_as_instructor.map { |course| course.name }.include? params[:course_name]
    @question_set = QuestionSet.new
    @questions = Question.where course_name: params[:course_name]
    @unselected_questions = @questions - @question_set.questions
  end

  def edit
    raise unless teaches_set
    @questions = Question.where course_name: @question_set.course_name
    @unselected_questions = @questions - @question_set.questions
  end

  def create
    @question_set = QuestionSet.new(question_set_params)
    raise unless current_user.courses_as_instructor.map { |course| course.name }.include? @question_set.course_name
    if params[:question_ids]
      @question_set.questions = params[:question_ids].map{|p| Question.find(p)}
    else
      @question_set.questions = []
    end
    @question_set.is_readonly = false
    if @question_set.save
      redirect_to @question_set, notice: 'Question set was successfully created.'
    else
      render :new
    end
  end

  def update
    raise unless teaches_set
    if params[:question_ids]
      @question_set.questions = params[:question_ids].map{|p| Question.find(p)}
    else
      @question_set.questions = []
    end
    if @question_set.update(question_set_params)
      redirect_to @question_set, notice: 'Question set was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    raise unless teaches_set
    @question_set.destroy
    redirect_to question_sets_url, notice: 'Question set was successfully destroyed.'
  end

  private
    def teaches_set
      current_user.courses_as_instructor.map { |course| course.name }.include? @question_set.course_name
    end

    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    def question_set_params
      params.require(:question_set).permit(:name, :course_name)
    end
end

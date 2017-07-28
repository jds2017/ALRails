class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]

  def index
    @names = current_user.courses_as_instructor.map { |c| c.name }.uniq
  end

  def show

  end

  def new
    @question_set = QuestionSet.new
    @questions = Question.where course_name: params[:course_name]
    @unselected_questions = @questions - @question_set.questions
  end

  def edit
    @questions = Question.where course_name: @question_set.course_name
    @unselected_questions = @questions - @question_set.questions
  end

  def create
    @question_set = QuestionSet.new(question_set_params)
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
    @question_set.destroy
    redirect_to question_sets_url, notice: 'Question set was successfully destroyed.'
  end

  private
    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    def question_set_params
      params.require(:question_set).permit(:name, :course_name)
    end
end

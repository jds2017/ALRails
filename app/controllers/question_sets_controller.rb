class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]

  def index
    names = current_user.courses_as_instructor.map { |c| c.name }
    @question_sets = QuestionSet.all.select { |qs| names.include? qs.course_name }
  end

  def show
    raise unless teaches_set
    @question_set.questions.first.course_name
  end

  def new
    @question_set = QuestionSet.new
    @questions = []
    current_user.courses_as_instructor.each {|c| @questions.push c.questions}
    @questions.flatten!
    @unselected_questions = []
    @unselected_questions = @questions - @question_set.questions
  end

  def edit
    @questions = []
    current_user.courses_as_instructor.each {|c| @questions.push c.questions}
    @questions.flatten!
    @unselected_questions = []
    @unselected_questions = @questions - @question_set.questions
  end

  def create
    @question_set = QuestionSet.new(question_set_params)
    @question_set.questions = params[:question_ids].map{|p| Question.find(p)}
    raise unless teaches_set
    @question_set.is_readonly = false
    if @question_set.save
      redirect_to @question_set, notice: 'Question set was successfully created.' 
    else
      render :new 
    end
  end

  def update
    @question_set.questions = params[:question_ids].map{|p| Question.find(p)}
    raise unless teaches_set
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
      course_name = @question_set.course_name
      current_user.courses_as_instructor.map {|c| c.name }.include? course_name
    end

    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    def question_set_params
      params.require(:question_set).permit(:name, :is_readonly)
    end
end

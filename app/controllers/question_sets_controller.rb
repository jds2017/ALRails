class QuestionSetsController < ApplicationController
  before_action :set_question_set, only: [:show, :edit, :update, :destroy]

  def index
    @question_sets = QuestionSet.all
  end

  def show
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
    @question_set.is_readonly = false

    respond_to do |format|
      if @question_set.save
        if params[:question_ids]
          params[:question_ids].each do |id|
            @j = QuestionSetJunction.new(:question_id => id, :question_set_id => @question_set.id)
            @j.save
          end
        end
        format.html { redirect_to @question_set, notice: 'Question set was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @question_set.name = :name
      if @question_set.update(question_set_params)
        QuestionSetJunction.where(question_set_id: @question_set.id).delete_all
        if params[:question_ids]
          params[:question_ids].each do |id|
            @j = QuestionSetJunction.new(:question_id => id, :question_set_id => @question_set.id)
            @j.save
          end
        end
        format.html { redirect_to @question_set, notice: 'Question set was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @question_set.destroy
    respond_to do |format|
      format.html { redirect_to question_sets_url, notice: 'Question set was successfully destroyed.' }
    end
  end

  private
    def set_question_set
      @question_set = QuestionSet.find(params[:id])
    end

    def question_set_params
      params.require(:question_set).permit(:name, :is_readonly)
    end
end

class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_answers, only: [:edit]

  def index
    @questions = []
    current_user.courses_as_instructor.each {|c| @questions.push c.questions}
    @questions.flatten!
  end

  def show
  end

  def new
    @question = Question.new
    5.times { @question.answers.build }
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      if params[:tags_list]
        tag_names_array = params[:tags_list].split(",")
        tag_names_array.map! {|tag| tag.strip.downcase}
        tag_names_array.uniq!
        @question.tags = []
        tag_names_array.each do |tagName|
          @t = Tag.find_or_create_by(tag: tagName)
          @question.tags.push(@t)
        end
      end
      redirect_to @question, notice: 'Question was successfully created.' 
    else
      render :new 
    end
  end

  def update
    if @question.update(question_params)
      if params[:tags_list]
        tag_names_array = params[:tags_list].split(",")
        tag_names_array.map! {|tag| tag.strip.downcase}
        tag_names_array.uniq!
        @question.tags = []
        tag_names_array.each do |tagName|
          @t = Tag.find_or_create_by(tag: tagName)
          @question.tags.push(@t)
        end
      end
      redirect_to @question, notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    def set_answers
      (5 - @question.answers().count).times { @question.answers.build }
    end

    def question_params
      params.require(:question).permit(:tags_list, :body, :course_name, :answers_attributes => [:answer, :id, :_destroy, :is_correct])
    end
end

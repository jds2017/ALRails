class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :set_answers, only: [:edit]

  # GET /questions
  # GET /questions.json
  def index
    @questions = []
    current_user.courses_as_instructor.each {|c| @questions.push c.questions}
    @questions.flatten!
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    5.times { @question.answers.build }
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        # check if there are any tags in the user input; add them to question's tags.
        if params[:tags_list]
          tag_names_array = params[:tags_list].split(",")
          tag_names_array.uniq!
          @question.tags = []
          # loop through tags from user input
          tag_names_array.each do |tagName|
            tagName = tagName.strip.downcase #remove leading/tailing whitespace and make uppercase
            @t = Tag.find_or_create_by(tag: tagName)
            @question.tags.push(@t)
          end
        end
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        # check if there are any tags in the user input; add them to question's tags.
        if params[:tags_list]
          tag_names_array = params[:tags_list].split(",")
          tag_names_array.uniq!
          @question.tags = []
          # loop through tags from user input
          tag_names_array.each do |tagName|
            tagName = tagName.strip.downcase #remove leading/tailing whitespace and make uppercase
            @t = Tag.find_or_create_by(tag: tagName)
            @question.tags.push(@t)
          end
        end
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_answers
      (5 - @question.answers().count).times { @question.answers.build }
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:tags_list, :body, :course_name, :answers_attributes => [:answer, :id, :_destroy, :is_correct])
    end
end

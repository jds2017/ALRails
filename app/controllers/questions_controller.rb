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
    #TODO: Retrieve the tag string ("malloc, logisim") from the params, split on the string
    # for each tag, check if it exists first. Create it if not. 
    # @question.tags = tags (before @question.save)
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        if params[:tags_list]
          tags_array = params[:tags_list].split(",")
          tags_array.each do |tagName|
            # Check if tag exists, create if not. 
          end
          puts params[:tags_list]
          @question.tags = :tags_list
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
    #TODO the same thing as in create
    respond_to do |format|
      if @question.update(question_params)
        if params[:tags_list]
          tag_names_array = params[:tags_list].split(",")
          tags = []
          tag_names_array.each do |tagName|
            if Tag.exists?(tag: tagName)
              @t = Tag.where(tag: tagName).first
            else
              @t = Tag.new(:tag => tagName)
              @t.save
            end
            tags.push(@t)
            # @existing_tag = Tag.where(tag: tagName).take
            puts tags
            # Check if tag exists, create if not. 
          end
          puts tags
          @question.tags = tags
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
      #TODO: permit the tag string here. 
      params.require(:question).permit(:tags_list, :body, :course_name, :answers_attributes => [:answer, :id, :_destroy, :is_correct])
    end
end

class QuestionToTagJunctionsController < ApplicationController
  before_action :set_question_to_tag_junction, only: [:show, :edit, :update, :destroy]

  # GET /question_to_tag_junctions
  # GET /question_to_tag_junctions.json
  def index
    @question_to_tag_junctions = QuestionToTagJunction.all
  end

  # GET /question_to_tag_junctions/1
  # GET /question_to_tag_junctions/1.json
  def show
  end

  # GET /question_to_tag_junctions/new
  def new
    @question_to_tag_junction = QuestionToTagJunction.new
  end

  # GET /question_to_tag_junctions/1/edit
  def edit
  end

  # POST /question_to_tag_junctions
  # POST /question_to_tag_junctions.json
  def create
    @question_to_tag_junction = QuestionToTagJunction.new(question_to_tag_junction_params)

    respond_to do |format|
      if @question_to_tag_junction.save
        format.html { redirect_to @question_to_tag_junction, notice: 'Question to tag junction was successfully created.' }
        format.json { render :show, status: :created, location: @question_to_tag_junction }
      else
        format.html { render :new }
        format.json { render json: @question_to_tag_junction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_to_tag_junctions/1
  # PATCH/PUT /question_to_tag_junctions/1.json
  def update
    respond_to do |format|
      if @question_to_tag_junction.update(question_to_tag_junction_params)
        format.html { redirect_to @question_to_tag_junction, notice: 'Question to tag junction was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_to_tag_junction }
      else
        format.html { render :edit }
        format.json { render json: @question_to_tag_junction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_to_tag_junctions/1
  # DELETE /question_to_tag_junctions/1.json
  def destroy
    @question_to_tag_junction.destroy
    respond_to do |format|
      format.html { redirect_to question_to_tag_junctions_url, notice: 'Question to tag junction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_to_tag_junction
      @question_to_tag_junction = QuestionToTagJunction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_to_tag_junction_params
      params.require(:question_to_tag_junction).permit(:question_id, :tag_id)
    end
end

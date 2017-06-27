class QuestionSetJunctionsController < ApplicationController
  before_action :set_question_set_junction, only: [:show, :edit, :update, :destroy]

  # GET /question_set_junctions
  # GET /question_set_junctions.json
  def index
    @question_set_junctions = QuestionSetJunction.all
  end

  # GET /question_set_junctions/1
  # GET /question_set_junctions/1.json
  def show
  end

  # GET /question_set_junctions/new
  def new
    @question_set_junction = QuestionSetJunction.new
  end

  # GET /question_set_junctions/1/edit
  def edit
  end

  # POST /question_set_junctions
  # POST /question_set_junctions.json
  def create
    @question_set_junction = QuestionSetJunction.new(question_set_junction_params)
    respond_to do |format|
      if @question_set_junction.save
        format.html { redirect_to @question_set_junction, notice: 'Question set junction was successfully created.' }
        format.json { render :show, status: :created, location: @question_set_junction }
      else
        format.html { render :new }
        format.json { render json: @question_set_junction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /question_set_junctions/1
  # PATCH/PUT /question_set_junctions/1.json
  def update
    respond_to do |format|
      if @question_set_junction.update(question_set_junction_params)
        format.html { redirect_to @question_set_junction, notice: 'Question set junction was successfully updated.' }
        format.json { render :show, status: :ok, location: @question_set_junction }
      else
        format.html { render :edit }
        format.json { render json: @question_set_junction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /question_set_junctions/1
  # DELETE /question_set_junctions/1.json
  def destroy
    @question_set_junction.destroy
    respond_to do |format|
      format.html { redirect_to question_set_junctions_url, notice: 'Question set junction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question_set_junction
      @question_set_junction = QuestionSetJunction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_set_junction_params
      params.require(:question_set_junction).permit(:question_id, :question_set_id)
    end
end

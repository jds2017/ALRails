class RegistrationsController < ApplicationController
  before_action :find_registration, only: [:show, :edit, :update, :destroy]
  before_action :validate_read, only: [:show, :edit]
  before_action :validate_modify, only: [:destroy, :update]

  # GET /registrations
  # GET /registrations.json
  def index
    if current_user.is_admin
      @registrations = Registration.all
    else
      @registrations = current_user.registrations
      current_user.courses_as_instructor.each { |c| @registrations += c.registrations }
      @registrations = @registrations.uniq { |r| r.id }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @registration = Registration.new
  end

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations
  # POST /registrations.json
  def create
      @registration = new_registration
    respond_to do |format|
      if @registration.save
        format.html { redirect_to @registration, notice: 'Registration was successfully created.' }
        format.json { render :show, status: :created, location: @registration }
      else
        format.html { render :new }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_url, notice: 'Registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def validate_read
      raise unless current_user.is_admin ||
        current_user.courses.include?(@registration.course)
    end

    def validate_modify
      raise unless current_user.is_admin ||
        current_user.courses_as_instructor.include?(@registration.course) ||
        (!current_user.is_professor && current_user.courses_as_instructor.include?(@registration.course) && @registration.role == 'STUDENT')
    end

    # Use callbacks to share common setup or constraints between actions.
    def find_registration
      @registration = Registration.find(params[:id])
    end

    def new_registration
        course = Course.where(student_key: registration_params[:student_key])
        @registration = Registration.new({user: current_user, course: course[0], role: "STUDENT"})
        return @registration
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:student_key)
    end
end

class RegistrationsController < ApplicationController
  before_action :find_registration, only: [:show, :edit, :update, :destroy]
  before_action :find_course

  def index
    @registrations = []
    current_user.courses_as_instructor.each do |c|
      if c == @course
        @registrations += c.registrations
      end
    end
    @registrations = @registrations.sort_by { |e| e[:role]}
  end

  def show
    raise unless current_user.teaches? @registration.course
  end

  def new
    @registration = Registration.new
  end

  def edit
    raise unless current_user.teaches? @registration.course
  end

  def create
    course = Course.find_by(student_key: registration_params[:student_key])
    if already_registered?
      redirect_to course, notice: 'You are already registered.' 
      return
    end
    @registration = new_registration
    if @registration.save
      redirect_to course, notice: 'Registration was successfully created.' 
    else
      render :new
    end
  end

  def update
    raise unless current_user.is_professor? && current_user.teaches?(@registration.course)
    if @registration.update(update_params)
      redirect_to @registration, notice: 'Registration was successfully updated.' 
    else
      render :edit
    end
  end

  def destroy
    raise unless current_user.is_professor? && current_user.teaches?(@registration.course)
    @registration.destroy
    redirect_to registrations_url, notice: 'Registration was successfully destroyed.'
  end

  private
    def find_registration
      @registration = Registration.find(params[:id])
    end

    def find_course
      @course = Course.find_by(id: params[:course_id])
    end

    def already_registered?
      course = Course.find_by(student_key: registration_params[:student_key])
      Registration.exists? user: current_user, course: course
    end

    def new_registration
      course = Course.find_by(student_key: registration_params[:student_key])
      Registration.new({user: current_user, course: course, role: "STUDENT"})
    end

    def registration_params
      params.require(:registration).permit(:student_key)
    end

    def update_params
      params.require(:registration).permit(:role)
    end
end

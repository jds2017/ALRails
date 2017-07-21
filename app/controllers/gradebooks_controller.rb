class GradebooksController < ApplicationController

  def index
    @course = Course.find params[:id]
    raise unless current_user.courses_as_instructor.include? @course
  end
end
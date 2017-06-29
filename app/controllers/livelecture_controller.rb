class LivelectureController < ApplicationController
  def show
    @lecture = Lecture.find_by(id: params[:lecture])
    render "livelecture"
  end
end

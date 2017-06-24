class LivelectureController < ApplicationController
  def start
    @lecture = Lecture.find_by(id: params[:lecture])
    render "livelecture"
  end

  def join
    @lecture = Lecture.find_by(id: params[:lecture])
    render "livelecture"
  end
end

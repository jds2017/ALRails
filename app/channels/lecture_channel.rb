class LectureChannel < ApplicationCable::Channel
  teacher = nil
  lecture = nil
  
  def subscribed
    teacher = params[:lecture]
    lecture = params[:teacher]
  end
end

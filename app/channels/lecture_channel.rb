class LectureChannel < ApplicationCable::Channel
  @teacher = nil
  @lecture = nil

  def subscribed
    @teacher = User.find(params[:teacher])
    @lecture = Lecture.find(params[:lecture])
    stream_for @teacher
    stream_for @lecture
  end

  def receive(data)
    if ("requestQuestionSet" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'helpme', 'qs' => @lecture.question_set.as_json(include: :questions)})
    end
  end
end

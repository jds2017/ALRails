class LectureChannel < ApplicationCable::Channel
  @teacher = nil
  @lecture = nil

  def subscribed
    if current_user.is_professor
      @teacher = current_user
      stream_for @teacher
    end
    @lecture = Lecture.find(params[:lecture])
    stream_for @lecture
  end

  def receive(data)
    if ("requestQuestionSet" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'helpme', 'qs' => @lecture.question_set.as_json(include: :questions)})
    end
    if ("join" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'join', 'user' => data['user']})
    end
  end
end

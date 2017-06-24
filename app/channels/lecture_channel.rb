class LectureChannel < ApplicationCable::Channel
  @lecture = nil

  def subscribed
    stream_for current_user
    @lecture = Lecture.find(params[:lecture])
    stream_for @lecture
  end

  def unsubscribed
    LectureChannel.broadcast_to(@lecture, {'msg' => 'exit', 'user' => current_user.to_s})
  end

  def receive(data)
    if ("requestQuestionSet" == data['msg'])
    end
    if ("join" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'join', 'user' => data['user']})
    end
    if ("question" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'question', 'body' => data['body']})
    end
    if ("response" == data['msg'])
      Response.create! lecture: @lecture, user: current_user, question_id: data['question'].to_i, answer_id: data['answer'].to_i
      LectureChannel.broadcast_to(@lecture, {'msg' => 'answer', 'answer' => data['answer']})
    end
  end
end

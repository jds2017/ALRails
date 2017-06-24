class LectureChannel < ApplicationCable::Channel
  @lecture = nil

  def subscribed
    @lecture = Lecture.find(params[:lecture])
    stream_for @lecture
    if current_user.is_professor
      stream_for "leader_#{@lecture.id}"
    end
  end

  def unsubscribed
    LectureChannel.broadcast_to(@lecture, {'msg' => 'exit', 'user' => current_user.to_s})
  end

  def receive(data)
    if ("requestQuestionSet" == data['msg'])
      LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'helpme', 'qs' => @lecture.question_set.as_json(include: { questions: {include: {answers: {except: :is_correct}}}})})
    end
    if ("join" == data['msg'])
      LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'join', 'user' => data['user']})
    end
    if ("question" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'question', 'body' => data['body']})
    end
    if ("response" == data['msg'])
      Response.create! lecture: @lecture, user: current_user, question_id: data['question'].to_i, answer_id: data['answer'].to_i
      LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'answer', 'answer' => data['answer']})
    end
  end
end

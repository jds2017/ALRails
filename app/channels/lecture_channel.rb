class LectureChannel < ApplicationCable::Channel
  @lecture = nil

  def subscribed
    stream_for current_user
    @lecture = Lecture.find(params[:lecture])
    stream_for @lecture
  end

  def receive(data)
    if ("requestQuestionSet" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'helpme', 'qs' => @lecture.question_set.as_json(include: { questions: {include: {answers: {except: :is_correct}}}})})
    end
    if ("join" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'join', 'user' => data['user']})
    end
    if ("question" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'question', 'body' => data['body']})
    end
    if ("response" == data['msg'])
      #todo record response data.answer ^ data.question ^ current_user
      Response.create! lecture: @lecture, user: current_user, question_id: data['question'].to_i, answer_id: data['answer'].to_i
    end
  end
end

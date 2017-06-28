class LectureChannel < ApplicationCable::Channel
  @lecture = nil
  @users = nil

  def subscribed
    @users = {}
    @lecture = Lecture.find(params[:lecture])
    stream_for @lecture
    if current_user.is_professor
      stream_for "leader_#{@lecture.id}"
    end
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'enter', user: current_user.username })
  end

  def unsubscribed
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'exit', user: current_user.username })
  end

  def receive(data)
    if ("requestConnectedUsers" == data['msg'])
      send_users
    end
    if ("requestQuestionSet" == data['msg'])
      LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'helpme', 'qs' => @lecture.question_set.as_json(include: { questions: {include: {answers: {except: :is_correct}}}})})
    end
    if ("question" == data['msg'])
      LectureChannel.broadcast_to(@lecture, {'msg' => 'question', 'body' => data['body']})
    end
    if ("response" == data['msg'])
      Response.create! lecture: @lecture, user: current_user, question_id: data['question'].to_i, answer_id: data['answer'].to_i
      LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'answer', 'answer' => data['answer']})
    end
  end

  def enter(data)
    @users[data['user']] = :connected
    send_users
  end

  def exit(data)
    @users[data['user']] = :disconnected
    send_users
  end

  def send_users
    user_fragment = ApplicationController.renderer.render(partial: 'livelecture/connected_users', locals: {users: @users})
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'userlist', 'view' => user_fragment})
  end
end

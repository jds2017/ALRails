class LectureChannel < ApplicationCable::Channel
  @lecture = nil
  @users = nil

  def subscribed
    @users = {current_user.username => :connected }
    @lecture = Lecture.find(params[:lecture])
    stream_for @lecture
    if current_user.is_professor
      LectureChannel.broadcast_to(@lecture, {'msg' => 'leaderEnter' })
      @questions = @lecture.question_set.questions
      stream_for "leader_#{@lecture.id}"
    end
    announce_presence
  end

  def unsubscribed
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'exit', user: current_user.username })
  end

  def receive(data)
    if ("requestConnectedUsers" == data['msg'])
      send_users
    end
    if ("requestSetSize" == data['msg'])
      size = @lecture.question_set.questions.length
      LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'setSize', 'size' => size })
    end
    if ("question" == data['msg'])
      question = @questions[data['id']]
      question_fragment = ApplicationController.renderer.render(partial: 'livelecture/question', locals: {question: question })
      LectureChannel.broadcast_to(@lecture, {'msg' => 'question', 'view' => question_fragment })
      question_fragment = ApplicationController.renderer.render(partial: 'livelecture/leader_question', locals: {question: question })
      LectureChannel.broadcast_to(@lecture, {'msg' => 'leaderQuestion', 'view' => question_fragment })
    end
    if ("response" == data['msg'])
      Response.create! lecture: @lecture, user: current_user, question_id: data['question'].to_i, answer_id: data['answer'].to_i
      LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'answer', 'answer' => data['answer']})
    end
  end

  def announce_presence
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'enter', user: current_user.username })
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

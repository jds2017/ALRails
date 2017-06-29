class LectureChannel < ApplicationCable::Channel

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

  def response(data)
    question_id = data['question_id']
    answer_id = data['answer_id']
    Response.create! lecture: @lecture, user: current_user, question_id: question_id.to_i, answer_id: answer_id.to_i
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'answer', 'answer' => answer_id})
  end

  def question(data)
    question = @questions[data['index']]
    question_fragment = ApplicationController.renderer.render(partial: 'livelecture/question', locals: {question: question })
    LectureChannel.broadcast_to(@lecture, {'msg' => 'question', 'view' => question_fragment })
    question_fragment = ApplicationController.renderer.render(partial: 'livelecture/leader_question', locals: {question: question })
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'leaderQuestion', 'view' => question_fragment })
  end

  def request_set_size
    size = @lecture.question_set.questions.length
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'setSize', 'size' => size })
  end

  def release_answer(data)
    question = @questions[data['index']]
    correct_answer = question.correct_answers[0]
    LectureChannel.broadcast_to(@lecture, {'msg' => 'correct_answer', 'answer' => correct_answer.id })
  end

  def request_connected_users
    send_users
  end

  def announce_presence
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'enter', user: current_user.username })
  end

  def enter(data)
    @users[data['username']] = :connected
    send_users
  end

  def exit(data)
    @users[data['username']] = :disconnected
    send_users
  end

  def send_users
    user_fragment = ApplicationController.renderer.render(partial: 'livelecture/connected_users', locals: {users: @users})
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'userlist', 'view' => user_fragment})
  end
end

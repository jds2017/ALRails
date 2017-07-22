class LectureChannel < ApplicationCable::Channel

  def subscribed
    @users = {current_user.username => :connected }
    @lecture = Lecture.find(params[:lecture])
    stream_for @lecture
    if current_user.courses_as_instructor.include? @lecture.question_set.questions[0].course
      stream_for "leader_#{@lecture.id}"
      LectureChannel.broadcast_to(@lecture, {'msg' => 'leader_enter' })
      @questions = @lecture.question_set.questions
    end
    announce_presence
  end

  def unsubscribed
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'exit', user: current_user.username })
  end

  def response(data)
    question_id = data['question_id']
    answer_id = data['answer_id']
    @response = Response.where(lecture: @lecture, user: current_user, question_id: question_id.to_i)
    if @response.empty?
        Response.create! lecture: @lecture, user: current_user, question_id: question_id.to_i, answer_id: answer_id.to_i
    else
        @response.update(answer_id: answer_id.to_i)
    end
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'answer', 'answer' => answer_id})
  end

  def question(data)
    question = @questions[data['index']]
    question_fragment = ApplicationController.renderer.render(partial: 'livelecture/question', locals: {question: question })
    LectureChannel.broadcast_to(@lecture, {'msg' => 'question', 'view' => question_fragment })
    question_fragment = ApplicationController.renderer.render(partial: 'livelecture/leader_question', locals: {question: question })
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'leader_question', 'view' => question_fragment })
  end

  def request_set_size
    size = @lecture.question_set.questions.length
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'set_size', 'size' => size })
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

  def end_of_lecture
    @lecture.update! completed: true
    LectureChannel.broadcast_to(@lecture, {'msg' => 'end_of_lecture'})
  end

  def send_users
    user_fragment = ApplicationController.renderer.render(partial: 'livelecture/connected_users', locals: {users: @users})
    LectureChannel.broadcast_to("leader_#{@lecture.id}", {'msg' => 'userlist', 'view' => user_fragment})
  end
  
  def edit_timer(data)
    timeChange = data['timeChange']
    LectureChannel.broadcast_to(@lecture, {'msg' => 'timeChange', 'timeChange' => timeChange})
  end
end

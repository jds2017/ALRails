var create_start_lecture = function(lecture_id) {
  if(App.lectureChannel) {
    console.log("killing lecture channel that is in progress");
    App.cable.subscriptions.remove(App.lectureChannel);
  }
  App.lectureChannel = App.cable.subscriptions.create({
    channel: "LectureChannel",
    lecture: lecture_id
  }, {
    disconnected: function() {
      $('#connection-status').text("disconnected");
    },
    connected: function() {
      create_timer();
      $('#connection-status').text("connected");
      request_set_size();
      request_connected_users();
    },
    received: function(data) {
      console.log(data);
      if(data.msg == 'set_size') {
        question_set_size = data.size;
        start_lecture();
      }
      if(data.msg == 'leader_question') {
        display_new_question(data.view);
      }
      if(data.msg == 'answer') {
        answer = data.answer;
        nextvalue = 1 + parseInt($('#answer-ctr-' + answer).text());
        $('#answer-ctr-' + answer).text('' + nextvalue);
      }
      if(data.msg == 'userlist') {
        $('#userlist').html(data.view);
      }
      if(data.msg == 'enter') {
        user_enter(data.user);
      }
      if(data.msg == 'exit') {
        user_leave(data.user);
      }
      if(data.msg === 'end_of_lecture') {
        $('#countdown').empty();
        $('#current-question').empty();
        $('#question-release').prop('disabled', true).css('opacity',0.5);
      }
      if(data.msg === 'timeChange') {
        edit_timer_receive(data.timeChange);
      }
    }
  });
}

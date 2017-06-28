var create_start_lecture = function(lecture_id) {
  if(App.lectureChannel && JSON.parse(App.lectureChannel.identifier).lecture === lecture_id) {
    console.log("lecture channel already exists");
    return;
  }
  if(App.lectureChannel && JSON.parse(App.lectureChannel.identifier).lecture !== lecture_id) {
    console.log("killing lecture channel that is in progress");
    App.cable.subscriptions.remove(App.lectureChannel);
  }
  App.lectureChannel = App.cable.subscriptions.create({
    channel: "LectureChannel",
    lecture: lecture_id
  }, {
    connected: function() {
      create_timer();
      $('#connection-status').text("connected");
      requestSetSize();
      requestConnectedUsers();
    },
    received: function(data) {
      console.log(data);
      if(data.msg == 'setSize') {
        question_set_size = data.size;
        startLecture();
      }
      if(data.msg == 'question') {
        display_new_question(data.view);
      }
      if(data.msg == 'answer') {
        answer = data.answer;
        nextvalue = 1 + parseInt($('#' + answer).text());
        $('#' + answer).text('' + nextvalue);
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
    }
  });
}

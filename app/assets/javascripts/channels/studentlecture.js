var create_join_lecture = function(lecture_id, username) {
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
    },
    received: function(data) {
      console.log(data);
      if(data.msg === 'question') {
        display_new_question(data.view);
      }
      if(data.msg === 'leader_enter') {
        announce_presence();
      }
      if(data.msg === 'correct_answer') {
        show_correct_answer(data.answer);
      }
    }
  });
}

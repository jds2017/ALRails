var create_join_lecture = function(lecture_id, username) {
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
    },
    received: function(data) {
      console.log(data);
      if(data.msg == 'question') {
        display_new_question(data.body);
      }
    }
  });
}

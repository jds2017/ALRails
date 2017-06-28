var question_seconds = 5;
var question_set_size = -1;
var question_index = 0;
var timer;

var create_timer = function() {
  timer = $("#countdown").countdown360({
      radius: 60,
      seconds: question_seconds,
      autostart: false,
      startOverAfterAdding: true
  });
}

var display_new_question = function(view) {
  timer.start();
  $('#current-question').html(view);
  $('.answer-button').click(function() {
    $('.answer-button').prop('disabled', true).css('opacity',0.5);
    App.lectureChannel.send({msg: 'response', question: $(this).data('qid'), answer: $(this).data('id') });
  });
}

var displayNextQuestion = function() {
  if(question_index === question_set_size) {
    return; // lecture is over
  }
  App.lectureChannel.send({msg: 'question', id: question_index })
  timer.start();
  question_index++;
}

var startLecture = function() {
  displayNextQuestion();
  window.setInterval(displayNextQuestion, 1000*question_seconds);
}

var requestSetSize = function() {
  App.lectureChannel.send({msg: 'requestSetSize'});
}

var requestConnectedUsers = function() {
  App.lectureChannel.send({msg: 'requestConnectedUsers'})
}

var user_enter = function(user) {
  App.lectureChannel.perform("enter", {user: user})
}

var user_leave = function(user) {
  App.lectureChannel.perform("exit", {user: user})
}

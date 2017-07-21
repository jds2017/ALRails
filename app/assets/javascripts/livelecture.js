var question_seconds = 60;
var answer_seconds = 5;
var question_set_size = -1;
var question_index = 0;
var timeoutID;
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
  initialize_question_view();
  $('.answer-button').click(function() {
    $('.answer-button').prop('disabled', true).css('opacity',0.5);
    App.lectureChannel.perform('response', {
      question_id: $(this).data('qid'),
      answer_id: $(this).data('id')
    });
  });
}

var display_next_question = function() {
  App.lectureChannel.perform('question', {index: question_index});
  timer.start();
}

var display_answer = function() {
  App.lectureChannel.perform('release_answer', {index: question_index});
  setTimeout(function() {
    $('#question-release').prop('disabled', false).css('opacity',1.0);
    question_index++;
  }, 1000*answer_seconds);
}

var start_lecture = function() {
  $('#question-release').click(function() {
    if(question_index === question_set_size) {
      App.lectureChannel.perform('end_of_lecture');
      return;
    }
    display_next_question();
    $('#question-release').prop('disabled', true).css('opacity',0.5);
    timeoutID = setTimeout(function() {
      display_answer();
      timer.stop();
    }, 1000*question_seconds);
  });
}

var request_set_size = function() {
  App.lectureChannel.perform('request_set_size')
}

var request_connected_users = function() {
  App.lectureChannel.perform('request_connected_users');
}

var user_enter = function(user) {
  App.lectureChannel.perform("enter", {username: user});
}

var user_leave = function(user) {
  App.lectureChannel.perform("exit", {username: user});
}

var announce_presence = function() {
  App.lectureChannel.perform('announce_presence');
}

var show_correct_answer = function(id) {
  $('.answer-button').prop('disabled', true).css('opacity',0.5);
  $('#answer-' + id).text($('#answer-' + id).text() + "CORRECT");
}

var edit_timer_send = function() {
  if (timer.getTimeRemaining() >= 0) {
    timeChange = parseInt(document.getElementById("timeChange").value);
    App.lectureChannel.perform('edit_timer', {timeChange: timeChange});
    clearTimeout(timeoutID);
    timeoutID = setTimeout(function() {
      display_answer();
      timer.stop();
    }, 1000*(timer.getTimeRemaining()+timeChange));
  }
}

var edit_timer_receive = function(timeChange) {
  timer.extendTimer(timeChange);
}

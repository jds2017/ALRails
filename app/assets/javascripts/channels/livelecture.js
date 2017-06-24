var question_seconds = 5;
var connected_users = {};
var question_set = {};
var question_index = 0;
var timer;

var create_join_lecture = function(lecture_id) {
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
      alert_presence();
    },
    received: function(data) {
      console.log(data);
      if(data.msg == 'question') {
        display_new_question(data.body);
      }
    }
  });
}

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
      requestQuestionSet();
    },
    received: function(data) {
      console.log(data);
      if(data.msg == 'join') {
        connected_users[data.user] = 'connected';
        populateConnectedUsers();
      }
      if(data.msg == 'exit') {
        connected_users[data.user] = 'disconnected';
        populateConnectedUsers();
      }
      if(data.msg == 'helpme') {
        question_set = data.qs;
        startLecture();
      }
      if(data.msg == 'answer') {
        answer = data.answer;
        nextvalue = 1 + parseInt($('#' + answer).text());
        $('#' + answer).text('' + nextvalue);
      }
    }
  });
}

var create_timer = function() {
  timer = $("#countdown").countdown360({
      radius: 60,
      seconds: question_seconds,
      autostart: false,
      startOverAfterAdding: true
  });
}

var populateConnectedUsers = function() {
  $('#list').empty();
  for (var user in connected_users) {
    if (connected_users[user] == 'connected') {
      $('#list').append('<li>' + user + '</li>');
    }
  }
}

var display_new_question = function(q) {
  timer.start();
  $('#question-text').text(q.body);
  $('#answers').empty();
  for (var i in q.answers) {
    $('#answers').append('<li><button class="answer-button" id=' + q.answers[i].id + '>Answer</button>' + q.answers[i].answer + '</li>');
  }
  $('.answer-button').click(function() {
    $('.answer-button').prop('disabled', true).css('opacity',0.5);
    var answer_id = this.id
    App.lectureChannel.send({msg: 'response', question: q.id, answer: this.id });
  });
}

var displayNextQuestion = function() {
  if(question_index === question_set.questions.length) {
    return;
  }
  var question = question_set.questions[question_index];
  var answers = question.answers;
  App.lectureChannel.send({msg: 'question', body: question })
  timer.start();
  $('#question-text').text(question.body);
  $('#answers').empty();
  for (var i in answers) {
    $('#answers').append('<li>' + answers[i].answer + '<p id=' + answers[i].id + '>0</p></li>');
  }
  question_index++;
}

var startLecture = function() {
  displayNextQuestion();
  window.setInterval(displayNextQuestion, 1000*question_seconds);
}

var requestQuestionSet = function() {
  App.lectureChannel.send({msg: 'requestQuestionSet'});
}

var alert_presence = function() {
  App.lectureChannel.send({msg: 'join', user: '<%= current_user %>'});
}

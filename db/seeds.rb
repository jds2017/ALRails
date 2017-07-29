compilers = Course.create! year: 2017, semester: 'SUMMER', name: 'CS4240'
networking = Course.create! year: 2015, semester: 'FALL', name: 'CS3251'
systems = Course.create! year: 2014, semester: 'SPRING', name: 'CS2200'

leahy = User.create! username: 'leahy', is_admin: true, is_professor: true
mary = User.create! username: 'mhb6', is_admin: false, is_professor: true
john = User.create! username: 'jtompkins8', is_admin: false, is_professor: false

Registration.create! role: 'INSTRUCTOR', user: john, course: compilers
Registration.create! role: 'INSTRUCTOR', user: john, course: networking 
Registration.create! role: 'INSTRUCTOR', user: mary, course: networking
Registration.create! role: 'INSTRUCTOR', user: mary, course: compilers
Registration.create! role: 'INSTRUCTOR', user: leahy, course: systems

malloc = Question.create! body: '{"ops":[{"insert":"an implementation of malloc can be found in glibc\n"}]}', course_name: 'CS4240'
register = Question.create! body: '{"ops":[{"insert":"register allocation is NP hard\n"}]}', course_name: 'CS4240'
block = Question.create! body: '{"ops":[{"insert":"A block is chunk of code for which there is only one flow of execution\n"}]}', course_name: 'CS4240'
tcp = Question.create! body: '{"ops":[{"insert":"True or False: AIMD is a a technique used for window size.\n"}]}', course_name: 'CS3251'
ivt = Question.create! body: '{"ops":[{"insert":"is the IVT located in which area of memory?\n"}]}', course_name: 'CS2200'

compilers_set = QuestionSet.create! name: 'parsing and scanning', is_readonly: false, course_name: 'CS4240'
compilers_set.questions = [malloc, register, block]
networking_set = QuestionSet.create! name: 'transport layer', is_readonly: false, course_name: 'CS3251'
networking_set.questions = [tcp]
systems_set = QuestionSet.create! name: 'lc3', is_readonly: false, course_name: 'CS2200'
systems_set.questions = [ivt]

malloc.tags = [Tag.create!(tag: 'malloc'), Tag.create!(tag: 'memory')]
register.tags = [Tag.create!(tag: 'register')]
block.tags = [Tag.create!(tag: 'block')]
tcp.tags = [Tag.create!(tag: 'congestion')]
ivt.tags = [Tag.create!(tag: 'ivt')]

Answer.create!(answer: 'true', is_correct: true, question: malloc)
Answer.create!(answer: 'false', question: malloc)
Answer.create!(answer: 'true', is_correct: true, question: register)
Answer.create!(answer: 'false', question: register)
Answer.create!(answer: 'true', is_correct: true, question: block)
Answer.create!(answer: 'false', question: block)
Answer.create!(answer: 'true', is_correct: true, question: tcp)
Answer.create!(answer: 'false', question: tcp)
Answer.create!(answer: 'true', is_correct: true, question: ivt)
Answer.create!(answer: 'false', question: ivt)

compilers_lecture = Lecture.create title: 'compilers first lecture', question_set: compilers_set.readonly_copy, course: compilers, completed: true
systems_lecture = Lecture.create title: 'ld3 project review', question_set: systems_set.readonly_copy, course: systems
networking_lecture = Lecture.create title: 'midterm review', question_set: networking_set.readonly_copy, course: networking


users = []
10.times.each do |i|
  user = User.create! username: "fakestudent-#{i}", is_admin: false, is_professor: false
  Registration.create! role: 'STUDENT', user: user, course: compilers
  compilers_lecture.question_set.questions.each do |q|
    Response.create! user: user, lecture: compilers_lecture, question: q, answer: q.answers.sample, created_at: "#{['JUNE', 'JULY'].sample} #{rand(1..30)} 2016"
  end
  networking_lecture.question_set.questions.each do |q|
    Response.create! user: user, lecture: networking_lecture, question: q, answer: q.answers.sample, created_at: "#{['JUNE', 'JULY'].sample} #{rand(1..30)} 2016"
  end
  users << user
end
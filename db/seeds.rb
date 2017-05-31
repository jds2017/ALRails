compilers = Course.create year: 2017, semester: 'SUMMER', name: 'CS 4240', student_key: '3h535jh-443j4n-fdfd'
Course.create year: 2015, semester: 'FALL', name: 'CS 3251', student_key: '45j43h5-n32j4-b34jk2'
Course.create year: 2014, semester: 'SPRING', name: 'CS 2200', student_key: '4jk23=3n423-kj324'


User.create username: 'jtompkins8', fname: 'john', lname: 'tompkins', is_admin: true
User.create username: 'rkalhan4', fname: 'robert', lname: 'kalhan', is_admin: false
User.create username: 'smaer', fname: 'sally', lname: 'maer', is_admin: false


Registration.create role: 'STUDENT', user: User.where(username: 'smaer').first, course: Course.where(name: 'CS 4240').first
Registration.create role: 'ASSISTANT', user: User.where(username: 'rkalhan4').first, course: Course.where(name: 'CS 4240').first


Tag.create tag: 'malloc'
Tag.create tag: 'circuit'
Tag.create tag: 'register allocation'

q1 = Question.create body: 'an implementation of malloc can be found in glibc'
q2 = Question.create body: 'register allocation is NP hard'
q3 = Question.create body: 'in logisim, you should backup your work periodically'

Answer.create answer: 'true', is_correct: true, question: q1
Answer.create answer: 'false', is_correct: false, question: q1

set = QuestionSet.create name: 'my first question set', is_readonly: true
QuestionSetJunction.create question: q1, question_set: set

lecture = Lecture.create title: 'compilers first lecture', date_of_use: 'June-3-2017', question_set: set

CourseToLectureJunction.create course: compilers, lecture: lecture

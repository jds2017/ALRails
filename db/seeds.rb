compilers = Course.create year: 2017, semester: 'SUMMER', name: 'CS 4240', student_key: '3h535jh-443j4n-fdfd'
Course.create year: 2015, semester: 'FALL', name: 'CS 3251', student_key: '45j43h5-n32j4-b34jk2'
Course.create year: 2014, semester: 'SPRING', name: 'CS 2200', student_key: '4jk23=3n423-kj324'


User.create username: 'jtompkins8', fname: 'john', lname: 'tompkins', is_admin: true
User.create username: 'rkalhan4', fname: 'robert', lname: 'kalhan', is_admin: false, is_professor: true
student = User.create username: 'smaer', fname: 'sally', lname: 'maer', is_admin: false
student2 = User.create username: 'srunner', fname: 'steve', lname: 'runner', is_admin: false


Registration.create role: 'STUDENT', user: student, course: Course.where(name: 'CS 4240').first
Registration.create role: 'STUDENT', user: student2, course: Course.where(name: 'CS 4240').first
Registration.create role: 'ASSISTANT', user: User.where(username: 'rkalhan4').first, course: Course.where(name: 'CS 4240').first
Registration.create role: 'ASSISTANT', user: prof, course: Course.where(name: "CS 2200").first

tag = Tag.create tag: 'malloc'
tag2 = Tag.create tag: 'circuit'
tag3 = Tag.create tag: 'register allocation'
tag4 = Tag.create tag: 'logisim'

q1 = Question.create body: 'an implementation of malloc can be found in glibc', course_name: 'CS 4240'
q2 = Question.create body: 'register allocation is NP hard', course_name: 'CS 4240'
q3 = Question.create body: 'in logisim, you should backup your work periodically', course_name: 'CS 2200'

QuestionToTagJunction.create question: q1, tag: tag
QuestionToTagJunction.create question: q2, tag: tag3
QuestionToTagJunction.create question: q3, tag: tag2
QuestionToTagJunction.create question: q3, tag: tag4

Answer.create answer: 'true', is_correct: true, question: q1
wrong = Answer.create answer: 'false', is_correct: false, question: q1

Answer.create answer: 'only on a tuesday', is_correct: false, question: q2
Answer.create answer: 'false', is_correct: true, question: q2
Answer.create answer: 'false, you should use a hdl', is_correct: true, question: q3
Answer.create answer: 'git is handy for logisim backups', is_correct: false, question: q3

set = QuestionSet.create name: 'my first question set', is_readonly: true
QuestionSetJunction.create question: q1, question_set: set
QuestionSetJunction.create question: q2, question_set: set
QuestionSetJunction.create question: q3, question_set: set

lecture = Lecture.create title: 'compilers first lecture', date_of_use: 'June-3-2017', question_set: set

CourseToLectureJunction.create course: compilers, lecture: lecture

Response.create user: student, lecture: lecture, question: q1, answer: wrong

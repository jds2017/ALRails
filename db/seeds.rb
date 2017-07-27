compilers = Course.create year: 2017, semester: 'SUMMER', name: 'CS4240', student_key: '3h535jh-443j4n-fdfd'
Course.create year: 2015, semester: 'FALL', name: 'CS3251', student_key: '45j43h5-n32j4-b34jk2'
Course.create year: 2014, semester: 'SPRING', name: 'CS2200', student_key: '4jk23=3n423-kj324'


User.create username: 'jtompkins8', fname: 'john', lname: 'tompkins', is_admin: true
User.create username: 'rkalhan4', fname: 'robert', lname: 'kalhan', is_admin: false, is_professor: true
student = User.create username: 'smaer', fname: 'sally', lname: 'maer', is_admin: false
student2 = User.create username: 'srunner', fname: 'steve', lname: 'runner', is_admin: false
prof = User.create username: 'testprof', fname: 'test', lname: 'prof', is_admin: false, is_professor: true

Registration.create role: 'STUDENT', user: student, course: Course.where(name: 'CS4240').first
Registration.create role: 'STUDENT', user: student2, course: Course.where(name: 'CS4240').first
Registration.create role: 'INSTRUCTOR', user: User.where(username: 'rkalhan4').first, course: Course.where(name: 'CS4240').first
Registration.create role: 'INSTRUCTOR', user: prof, course: Course.where(name: "CS2200").first

tag = Tag.create tag: 'malloc'
tag2 = Tag.create tag: 'circuit'
tag3 = Tag.create tag: 'register allocation'
tag4 = Tag.create tag: 'logisim'

q1 = Question.create body: '{"ops":[{"insert":"an implementation of malloc can be found in glibc\n"}]}', course_name: 'CS4240'
q2 = Question.create body: '{"ops":[{"insert":"register allocation is NP hard\n"}]}', course_name: 'CS4240'
q3 = Question.create body: '{"ops":[{"insert":"in logisim, you should backup your work periodically\n"}]}', course_name: 'CS4240'

QuestionToTagJunction.create question: q1, tag: tag
QuestionToTagJunction.create question: q2, tag: tag3
QuestionToTagJunction.create question: q3, tag: tag2
QuestionToTagJunction.create question: q3, tag: tag4

right1 = Answer.create answer: 'true', is_correct: true, question: q1
wrong1 = Answer.create answer: 'false', is_correct: false, question: q1
wrong2 = Answer.create answer: 'only on a tuesday', is_correct: false, question: q2
right2 = Answer.create answer: 'false', is_correct: true, question: q2
right3 = Answer.create answer: 'false, you should use a hdl', is_correct: true, question: q3
wrong3 = Answer.create answer: 'git is handy for logisim backups', is_correct: false, question: q3

set = QuestionSet.create name: 'my first question set', is_readonly: false, course_name: 'CS4240'
QuestionSetJunction.create question: q1, question_set: set
QuestionSetJunction.create question: q2, question_set: set
QuestionSetJunction.create question: q3, question_set: set

lecture = Lecture.create title: 'compilers first lecture', question_set: set.readonly_copy, course: compilers

CourseToLectureJunction.create course: compilers, lecture: lecture

Response.create user: student, lecture: lecture, question: q1, answer: wrong1, created_at: 'July 6 2016'
Response.create user: student, lecture: lecture, question: q2, answer: wrong2, created_at: 'June 16 2016'
Response.create user: student, lecture: lecture, question: q3, answer: right3, created_at: 'July 1 2016'
Response.create user: student2, lecture: lecture, question: q1, answer: right1, created_at: 'July 26 2016'
Response.create user: student2, lecture: lecture, question: q2, answer: right2, created_at: 'July 4 2016'
Response.create user: student2, lecture: lecture, question: q3, answer: right3, created_at: 'June 6 2016'

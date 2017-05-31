Course.create year: 2017, semester: 'SUMMER', name: 'CS 4240', student_key: '3h535jh-443j4n-fdfd'
Course.create year: 2015, semester: 'FALL', name: 'CS 3251', student_key: '45j43h5-n32j4-b34jk2'
Course.create year: 2014, semester: 'SPRING', name: 'CS 2200', student_key: '4jk23=3n423-kj324'


User.create username: 'jtompkins8', fname: 'john', lname: 'tompkins', is_admin: true
User.create username: 'rkalhan4', fname: 'robert', lname: 'kalhan', is_admin: false
User.create username: 'smaer', fname: 'sally', lname: 'maer', is_admin: false


Registration.create role: 'STUDENT', user: User.where(username: 'smaer').first, course: Course.where(name: 'CS 2200').first

Tag.create tag: 'malloc'
Tag.create tag: 'circuit'
Tag.create tag: 'register allocation'

Question.create body: 'an implementation of malloc can be found in glibc'
Question.create body: 'register allocation is NP hard'
Question.create body: 'in logisim, you should backup your work periodically'

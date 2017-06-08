require "application_system_test_case"

class QuestionsTest < ApplicationSystemTestCase
  test "answers get saved with questions" do
    visit '/questions?un=john'
    click_on 'New Question'
    fill_in 'Body', with: 'yesorno'
    find('#question_answers_attributes_0_answer').set 'yes'
    find('#question_answers_attributes_1_answer').set 'no'
    find('#question_answers_attributes_0_is_correct').set(true)
    select('CourseTwo', :from => 'question[course_name]')
    click_on 'Create Question'
    assert_text 'Question was successfully created.'
    click_on 'Edit'
    assert_equal 1, Question.find_by(body: 'yesorno').correct_answers.size
    assert_equal 'yes', Question.find_by(body: 'yesorno').correct_answers.first.answer
    assert_equal 5, Question.find_by(body: 'yesorno').answers.size
    find('#question_answers_attributes_0_is_correct').set(false)
    find('#question_answers_attributes_1_is_correct').set(true)
    click_on 'Update Question'
    assert_text 'yesorno'
    assert_equal 1, Question.find_by(body: 'yesorno').correct_answers.size
    assert_equal 'no', Question.find_by(body: 'yesorno').correct_answers.first.answer
    assert_equal 5, Question.find_by(body: 'yesorno').answers.size
  end

  test "question not visible by student" do
    visit '/questions?un=john'
    assert_text 'qtwo'
    visit '/questions?un=astudent'
    assert_no_text 'qtwo'
  end
end

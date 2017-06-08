require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "reads questions" do
    assert_equal 2, Course.find_by(name: 'CourseOne').questions.size()
  end
  test "finds correct answers" do
    assert_equal 1, Question.find_by(body: 'qone').correct_answers.size()
  end
end

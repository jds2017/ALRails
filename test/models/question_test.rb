require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "reads questions" do
    assert_equal 2, Course.where(name: 'CourseOne').first.questions.size()
  end
end

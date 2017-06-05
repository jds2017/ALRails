require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "reads questions" do
    assert_equal 2, Course.find_by(name: 'CourseOne').questions.size()
  end
end

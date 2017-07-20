require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "percent correct" do
    assert_equal 50.0, Course.find_by(name: 'XX9999').pct_correct 
  end
end

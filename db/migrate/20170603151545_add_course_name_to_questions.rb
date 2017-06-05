class AddCourseNameToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :course_name, :string
  end
end

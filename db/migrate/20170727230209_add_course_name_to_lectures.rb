class AddCourseNameToLectures < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :lectures, :courses
    add_column :question_sets, :course_name, :string
  end
end

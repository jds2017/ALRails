class CreateCourseToLectureJunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :course_to_lecture_junctions do |t|
      t.belongs_to :course, foreign_key: true
      t.belongs_to :lecture, foreign_key: true

      t.timestamps
    end
  end
end

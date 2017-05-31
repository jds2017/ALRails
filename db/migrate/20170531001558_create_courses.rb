class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :year
      t.string :semester
      t.string :name
      t.string :student_key

      t.timestamps
    end
  end
end

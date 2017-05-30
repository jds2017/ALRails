class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.time :start
      t.time :end
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

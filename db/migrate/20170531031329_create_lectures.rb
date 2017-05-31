class CreateLectures < ActiveRecord::Migration[5.1]
  def change
    create_table :lectures do |t|
      t.string :title
      t.date :date_of_use
      t.belongs_to :question_set, foreign_key: true

      t.timestamps
    end
  end
end

class CreateQuestionSetJunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :question_set_junctions do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :question_set, foreign_key: true

      t.timestamps
    end
  end
end

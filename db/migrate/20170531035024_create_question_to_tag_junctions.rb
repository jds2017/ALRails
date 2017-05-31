class CreateQuestionToTagJunctions < ActiveRecord::Migration[5.1]
  def change
    create_table :question_to_tag_junctions do |t|
      t.belongs_to :question, foreign_key: true
      t.belongs_to :tag, foreign_key: true

      t.timestamps
    end
  end
end

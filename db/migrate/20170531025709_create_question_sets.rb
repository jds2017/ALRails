class CreateQuestionSets < ActiveRecord::Migration[5.1]
  def change
    create_table :question_sets do |t|
      t.string :name
      t.boolean :is_readonly

      t.timestamps
    end
  end
end

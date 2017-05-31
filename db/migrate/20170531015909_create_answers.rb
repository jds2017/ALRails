class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :answer
      t.boolean :is_correct
      t.belongs_to :question, foreign_key: true

      t.timestamps
    end
  end
end

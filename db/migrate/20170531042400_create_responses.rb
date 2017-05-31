class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.belongs_to :lecture, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :question, foreign_key: true
      t.belongs_to :answer, foreign_key: true

      t.timestamps
    end
  end
end

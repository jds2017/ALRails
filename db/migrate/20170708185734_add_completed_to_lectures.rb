class AddCompletedToLectures < ActiveRecord::Migration[5.1]
  def change
    add_column :lectures, :completed, :boolean, :default => false
  end
end

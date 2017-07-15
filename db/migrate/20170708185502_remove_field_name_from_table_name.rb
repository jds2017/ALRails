class RemoveFieldNameFromTableName < ActiveRecord::Migration[5.1]
  def change
    remove_column :lectures, :date_of_use, :date
  end
end

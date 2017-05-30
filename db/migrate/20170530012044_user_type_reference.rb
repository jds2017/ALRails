class UserTypeReference < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :user_type, foreign_key: true
  end
end

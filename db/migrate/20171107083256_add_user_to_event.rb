class AddUserToEvent < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :user, foreign_key: true, index: true
  end
end

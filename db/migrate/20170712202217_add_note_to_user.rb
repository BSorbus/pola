class AddNoteToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :note, :text, default: ""
  end
end

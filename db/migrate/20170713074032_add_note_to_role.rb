class AddNoteToRole < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :note, :text, default: ""
  end
end

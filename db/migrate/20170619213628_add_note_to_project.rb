class AddNoteToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :note, :text
  end
end

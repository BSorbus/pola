class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :number, index: true
      t.text :note

      t.timestamps
    end
  end
end

class CreatePointFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :point_files do |t|
      t.references :project, foreign_key: true
      t.date :load_date
      t.string :load_file
      t.integer :status
      t.text :note

      t.timestamps
    end
  end
end

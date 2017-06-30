class CreateAccessorizations < ActiveRecord::Migration[5.1]
  def change
    create_table :accessorizations do |t|
      t.integer :project_id, index: true
      t.integer :user_id, index: true
      t.integer :role_id, index: true

      t.timestamps      
    end
    add_index :accessorizations, [:project_id, :user_id],     unique: true
    add_index :accessorizations, [:user_id, :project_id],     unique: true
  end
end

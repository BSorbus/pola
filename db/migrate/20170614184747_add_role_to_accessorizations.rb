class AddRoleToAccessorizations < ActiveRecord::Migration[5.1]
  def change
    add_column :accessorizations, :role_id, :integer
  end
end

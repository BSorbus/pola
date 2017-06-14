class RemovePowersFromAccessorizations < ActiveRecord::Migration[5.1]
  def change
    remove_column :accessorizations, :powers, :integer
  end
end

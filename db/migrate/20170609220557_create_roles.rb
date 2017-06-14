class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :activities, array: true, length: 30, using: 'gin', default: '{}'


      t.timestamps
    end
  end
end

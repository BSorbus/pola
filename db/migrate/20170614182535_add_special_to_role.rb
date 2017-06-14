class AddSpecialToRole < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :special, :boolean, null: false, default: false, index: true
    Role.where(name: ['Administrator Systemowy', 'Administrator Biznesowy']).update_all(special: true)  
  end
end

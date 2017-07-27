class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.boolean :all_day
      t.datetime :start_date
      t.datetime :end_date
      t.string :color
      t.string :url_action

      t.timestamps
    end
  end
end

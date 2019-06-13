class CreateFlows < ActiveRecord::Migration[5.1]
  def change
    create_table :flows do |t|
      t.references :business_trip, foreign_key: true, index: true
      t.references :business_trip_status, foreign_key: true
      t.references :business_trip_status_updated_user, index: true
      t.datetime :business_trip_status_updated_at, index: true

      t.timestamps
    end
    add_foreign_key :flows, :users, column: :business_trip_status_updated_user_id, primary_key: :id

  end
end

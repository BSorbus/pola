class CreateBusinessTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :business_trips do |t|
      t.string :number
      t.references :employee, index: true
      t.date :start_date
      t.date :end_date
      t.string :destination
      t.text :purpose, default: ""
      t.text :trip_confirmation, default: ""
      t.decimal :payment_on_account, precision: 8, scale: 2, default: 0.00
      t.references :payment_on_account_approved, index: true
      t.datetime :payment_on_account_approved_date_time
      t.text :note, default: ""
      t.references :business_trip_status, foreign_key: true, default: 1, index: true
      t.references :business_trip_status_updated_user, index: true
      t.datetime :business_trip_status_updated_at
      t.references :user, foreign_key: true, index: true
      t.integer :hotel

      t.timestamps
    end
    #add_index :business_trips, [:number], unique: true

    # Rails 5+ only: add foreign keys
    add_foreign_key :business_trips, :users, column: :employee_id, primary_key: :id
    add_foreign_key :business_trips, :users, column: :business_trip_status_updated_user_id, primary_key: :id

  end
end

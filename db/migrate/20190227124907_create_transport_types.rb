class CreateTransportTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :transport_types do |t|
      t.string :name

      t.timestamps
    end
    transport_type1 = TransportType.find_or_create_by!(name: "PKP II kl.")
    transport_type2 = TransportType.find_or_create_by!(name: "Samochód służbowy")
    transport_type3 = TransportType.find_or_create_by!(name: "Samolot")
  end
end

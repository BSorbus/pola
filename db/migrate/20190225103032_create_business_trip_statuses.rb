class CreateBusinessTripStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :business_trip_statuses do |t|
      t.string :name, null: false
      t.integer :step, null: false

      t.timestamps
    end
    add_index :business_trip_statuses, :name, :unique => true
    add_index :business_trip_statuses, :step, :unique => true


    BusinessTripStatus.find_or_create_by!(name: "0.1 [DELEGOWANY] - Wniosek o PWS", step: 1)
    BusinessTripStatus.find_or_create_by!(name: "1.1 [WOP] - PWS w akceptacji", step: 11)
    BusinessTripStatus.find_or_create_by!(name: "2.1 [DELEGOWANY] - PWS zakceptawane, w rozliczeniu", step: 21)

    BusinessTripStatus.find_or_create_by!(name: "3.1 [WOP] - Do weryfikacji", step: 31)
    BusinessTripStatus.find_or_create_by!(name: "4.1 [BF] - Do weryfikacji", step: 41)

    BusinessTripStatus.find_or_create_by!(name: "5.1 [DELEGOWANY] - Zweryfikowano BF, dokumenty do wysyłki", step: 51)
    BusinessTripStatus.find_or_create_by!(name: "6.1 [WOP] - Dokumenty do akceptacji", step: 61)
    BusinessTripStatus.find_or_create_by!(name: "7.1 [BF] - Dokumenty przekazane do BF", step: 71)
      #BusinessTripStatus.find_or_create_by!(name: "Do ponownej akceptacji")
      #BusinessTripStatus.find_or_create_by!(name: "Przekazane ponowne do BF")
 


    # BusinessTripStatus.find_or_create_by!(name: "Wniosek o zaliczkę")
    # BusinessTripStatus.find_or_create_by!(name: "Zatwierdzony wniosek o zaliczkę")
    # BusinessTripStatus.find_or_create_by!(name: "Zaliczka w akceptacji")
    # BusinessTripStatus.find_or_create_by!(name: "Zaliczka w zaakceptowana")

    BusinessTripStatus.find_or_create_by!(name: "9.9. Zakończone", step: 99)

  end
end


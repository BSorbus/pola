class CreateErrandTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :errand_types do |t|
      t.string :name, index: true

      t.timestamps
    end
    errand_type1 = ErrandType.find_or_create_by!(name: "Ocena")
    errand_type2 = ErrandType.find_or_create_by!(name: "Ocena protest")
    errand_type3 = ErrandType.find_or_create_by!(name: "Analiza Sąd")
    errand_type4 = ErrandType.find_or_create_by!(name: "Opinia zmian")
    errand_type5 = ErrandType.find_or_create_by!(name: "Kontrola realizacja")
    errand_type6 = ErrandType.find_or_create_by!(name: "Kontrola zakończenie")
    errand_type7 = ErrandType.find_or_create_by!(name: "Kontrola trwałość")
    errand_type8 = ErrandType.find_or_create_by!(name: "Analiza danych")
    errand_type9 = ErrandType.find_or_create_by!(name: "Hurt cenniki")
    errand_type0 = ErrandType.find_or_create_by!(name: "Inne")
  end
end

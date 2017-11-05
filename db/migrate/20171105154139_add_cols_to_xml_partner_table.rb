class AddColsToXmlPartnerTable < ActiveRecord::Migration[5.1]
  def change
    add_column :xml_partner_tables, :wojewodztwo, :string, index: true
    add_column :xml_partner_tables, :powiat, :string, index: true
    add_column :xml_partner_tables, :gmina, :string, index: true

    reversible do |direction|
      direction.up { 

        XmlPartnerTable.all.each do |row|
          row.update_columns( 
            gmina: row.dp_as_miejscowosc_opis.split[2].gsub(',', ''),
            powiat: row.dp_as_miejscowosc_opis.split[4].gsub(',', ''),
            wojewodztwo: row.dp_as_miejscowosc_opis.split[6].gsub(')', '')
          )
        end  

      }
    end

  end
end

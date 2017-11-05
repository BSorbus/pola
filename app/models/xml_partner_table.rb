class XmlPartnerTable < ApplicationRecord
  belongs_to :proposal_file

  has_many :xml_miejsce_realizacji_tables, dependent: :delete_all, index_errors: true

  accepts_nested_attributes_for :xml_miejsce_realizacji_tables, reject_if: :all_blank, allow_destroy: true

  before_save :load_regions


  # Rzeszów (g. Rzeszów, p. Rzeszów, w. PODKARPACKIE) [703826]
  def load_regions
    self.gmina = dp_as_miejscowosc_opis.split[2]
    self.powiat = dp_as_miejscowosc_opis.split[4]
    self.wojewodztwo = dp_as_miejscowosc_opis.split[6].gsub(')', '') 
  end

end

class ProposalFile < ApplicationRecord
  enum status: [:inactive, :active]

  mount_uploader :load_file, ProposalFileUploader

  # relations
  belongs_to :project

  # validates
  validates :load_file, presence: true,
                        file_size: { less_than: 50.megabytes }

  validates :status, presence: true,
                    :uniqueness => { scope: [:project_id] }, if: :status_active?

  before_save :loading_file_is_valid?, on: :create

  def loading_file_is_valid?
    unless check_xml_file
      errors.add(:load_file, '"' + load_file.file.original_filename + '" nie jest prawidłowym plikiem XML projektu POPC (nabór 2)".')
      throw :abort 
    end
  end

  def status_active?
    self.active?
  end

  def fullname
    "#{self.load_file_identifier}"
  end

  def check_xml_file
    doc = Nokogiri::XML(File.open("#{self.load_file.file.path}", "r")) do |config|
      config.strict.nonet
    end

    required_1 = '2'
    required_2 = 'POPC'
    line_1 = ''
    line_2 = ''

    doc.xpath("//*[local-name()='Dokument']").each do |dokument|
      dokument.xpath("//*[local-name()='TrescDokumentu']").each do |tresc_dokumentu|
        tresc_dokumentu.xpath("./*[local-name()='Wniosek']").each do |wniosek|
          #puts wniosek.xpath("./*[local-name()='NumerWniosku']").text
          wniosek.xpath("./*[local-name()='Nabor']").each do |nabor|
            line_1 = nabor.xpath("./*[local-name()='Id']").text
            line_2 = nabor.xpath("./*[local-name()='Opis']").text.present? ? nabor.xpath("./*[local-name()='Opis']").text.first(4) : ''
          end #/nabor
        end #/wniosek
      end #/tresc_dokumentu
    end #/dokument

    line_1 == required_1 && line_2 == required_2
  end

  def load_data_from_xml_file
  end

end

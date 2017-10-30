require 'csv'

class Rating < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  # relations
  belongs_to :event
  belongs_to :user

  # validates
  validates :event_id, presence: true,  
                      uniqueness: { message: "Ocena do tego zadania już istnieje" }  
  validates :sec33_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 200 } 
                      

  def fullname
    "[dotyczy zadania: #{self.event.fullname}, projekt: #{self.event.project.fullname}]"
  end

  def fullname_as_link
    "<a href=#{url_helpers.event_rating_path(self.event, self)}>#{self.fullname}</a>".html_safe
  end

  def lastwritter
    if self.new_record?
      "Nowy wpis!"
    else
      "#{self.user.try(:name_as_link)}, #{self.updated_at.strftime("%Y-%m-%d %H:%M")}".html_safe
    end
  end

  # rubocop:disable MethodLength
  def to_xls
    CSV.generate(headers: false, col_sep: ',', converters: nil, skip_blanks: false, force_quotes: false) do |csv|
      columns_header = %w(event project customer )
      csv << columns_header
      csv << [self.event.fullname,
              self.event.project.fullname,
              self.event.project.customer.fullname] 
      # all.each do |rec|
      #   csv << [rec.number.strip,
      #           rec.valid_to,
      #           rec.call_sign,
      #           rec.category,
      #           rec.transmitter_power,
      #           rec.applicant_name,
      #           rec.applicant_city,
      #           rec.applicant_street,
      #           rec.applicant_house,
      #           rec.applicant_number,
      #           rec.enduser_name,
      #           rec.enduser_city,
      #           rec.enduser_street,
      #           rec.enduser_house,
      #           rec.enduser_number,
      #           rec.station_city,
      #           rec.station_street,
      #           rec.station_house,
      #           rec.station_number]
      # end
    end.encode('WINDOWS-1250')
  end

end

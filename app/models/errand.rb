class Errand < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  include  ActionView::Helpers::SanitizeHelper

  # relations
  belongs_to :errand_status

  has_many :attachments, as: :attachmenable, dependent: :destroy
  has_many :events, dependent: :nullify, index_errors: true

  belongs_to :user
  has_many :works, as: :trackable

  # validates
  validates :number, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }
  validates :principal, presence: true,
                    length: { in: 1..100 }
  validates :order_date, presence: true

  validate :all_date_correct, on: [:create, :update]

  # callbacks
  before_destroy :has_important_links, prepend: true

  after_create_commit { self.log_work('create') }
  after_update_commit { self.log_work('update') }


  def log_work(type)
    self.works.create!(trackable_url: "#{url_helpers.errand_path(self)}", action: "#{type}", user: self.user, 
      parameters: self.to_json(except: [:errand_status_id], include: {errand_status: {only: [:id, :name]}}))
  end

  def all_date_correct
    analize_value = true
    if self.order_date.present? && self.order_date > Time.zone.now.to_date
     errors.add(:order_date, '- błędna data')
     analize_value = false
    end

    if self.adoption_date.present? && self.adoption_date > Time.zone.now.to_date
     errors.add(:adoption_date, '- błędna data')
     analize_value = false
    end

    if self.order_date.present? && self.adoption_date.present? && self.order_date > self.adoption_date
     errors.add(:adoption_date, '- błędna data. Data przyjęcia zlecenia wcześniejsza od Daty zlecenia')
     analize_value = false
    end

    if self.start_date.present? && self.start_date > Time.zone.now.to_date
     errors.add(:start_date, '- błędna data')
     analize_value = false
    end

    if self.start_date.present? && self.end_date.present? && self.start_date > self.end_date
     errors.add(:end_date, '- błędna data. Data zakończenia wcześniejsza od Daty rozpoczęcia')
     analize_value = false
    end

    if self.order_date.present? && self.start_date.present? && self.order_date > self.start_date
     errors.add(:start_date, '- błędna data. Data rozpoczęcia wcześniejsza od Daty zlecenia')
     analize_value = false
    end

    if self.adoption_date.present? && self.start_date.present? && self.adoption_date > self.start_date
     errors.add(:start_date, '- błędna data. Data rozpoczęcia wcześniejsza od Daty przyjęcia zlecenia')
     analize_value = false
    end

    if self.order_date.present? && self.end_date.present? && self.order_date > self.end_date
     errors.add(:end_date, '- błędna data. Data zakończenia wcześniejsza od Daty zlecenia')
     analize_value = false
    end

    if self.adoption_date.present? && self.end_date.present? && self.adoption_date > self.end_date
     errors.add(:end_date, '- błędna data. Data zakończenia wcześniejsza od Daty przyjęcia zlecenia')
     analize_value = false
    end


    throw :abort unless analize_value 
  end


  def has_important_links
    analize_value = true
    if self.events.any? 
     errors.add(:base, 'Nie można usunąć zlecenia "' + self.try(:fullname) + '" do którego są przypisane Zadania.')
     analize_value = false
    end
    throw :abort unless analize_value 
  end

  def fullname
    "#{self.number} [#{self.order_date}, #{self.adoption_date}] [#{self.errand_status.name}]"
  end

  def number_as_link
    "<a href=#{url_helpers.errand_path(self)}>#{self.fullname}</a>".html_safe
  end

  scope :finder_errand, ->(q) { where( create_sql_string("#{q}") ) }

  def self.create_sql_string(query_str)
    query_str.split.map { |par| one_param_sql(par) }.join(" AND ")
  end

  def self.one_param_sql(one_query_word)
    #escaped_query_str = sanitize("%#{query_str}%")
    escaped_query_str = Loofah.fragment("'%#{one_query_word}%'").text
    "(" + %w(errands.number errands.principal to_char(errands.order_date,'YYYY-mm-dd') to_char(errands.adoption_date,'YYYY-mm-dd')).map { |column| "#{column} ilike #{escaped_query_str}" }.join(" OR ") + ")"
  end

end

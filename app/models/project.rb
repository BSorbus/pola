class Project < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  include  ActionView::Helpers::SanitizeHelper

  # relations
  belongs_to :project_status
  belongs_to :customer

  has_many :point_files, dependent: :destroy
  has_one :last_active_point_file, -> { where(status: :active).order(load_date: :desc) },
    class_name: 'PointFile', foreign_key: :project_id

  has_many :attachments, as: :attachmenable, dependent: :destroy

  has_many :events, dependent: :nullify, index_errors: true
  has_many :comments, through: :events, source: :comments

  has_many :opinions, dependent: :destroy

  # validates
  validates :number, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }

  validates :customer_id, presence: true

  # callbacks
  before_destroy :has_links, prepend: true



  def has_links
    analize_value = true
    if self.events.any? 
     errors.add(:base, 'Nie można usunąć projektu "' + self.try(:fullname) + '" do którego są przypisane Zadania.')
     analize_value = false
    end
    throw :abort unless analize_value 
  end

  def fullname
    "#{self.number}"
  end

  def number_as_link
    "<a href=#{url_helpers.project_path(self)}>#{self.fullname}</a>".html_safe
  end

  def flat_assigned_events
    # 1. Without sort by user.name
    self.events.order(end_date: :desc).flat_map {|row| "#{row.try(:title_as_link)}" }.join('<br>').html_safe
  end

  def flat_assigned_events_with_status
    self.events.order(end_date: :desc).flat_map {|row| "#{row.try(:title_as_link)} - [#{row.event_status.name}]" }.join('<br>').html_safe
  end

  # Scope for select2: "project_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "2017 wymaga"
  # * result   :
  #   * +scope+ -> collection 
  #
  scope :finder_project, ->(q) { where( create_sql_string("#{q}") ) }

  # Method create SQL query string for finder select2: "project_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "2017 wymaga"
  # * result   :
  #   * +sql_string+ -> string for SQL WHERE... 
  #   Eg.: "((projects.number ilike '%2017%' OR projects.note ilike '%2017%') AND (projects.number ilike '%wymaga%' OR projects.note ilike '%wymaga%'))"
  #
  def self.create_sql_string(query_str)
    query_str.split.map { |par| one_param_sql(par) }.join(" AND ")
  end

  # Method for glue parameters in create_sql_string
  # * parameters   :
  #   * +one_query_word+ -> word for search. 
  #   Eg.: "2017"
  # * result   :
  #   * +sql_string+ -> SQL string query for one word 
  #   Eg.: "(projects.number ilike '%2017%' OR projects.note ilike '%2017%')"
  #
  def self.one_param_sql(one_query_word)
    #escaped_query_str = sanitize("%#{query_str}%")
    escaped_query_str = Loofah.fragment("'%#{one_query_word}%'").text
    "(" + %w(projects.number projects.note).map { |column| "#{column} ilike #{escaped_query_str}" }.join(" OR ") + ")"
  end


end

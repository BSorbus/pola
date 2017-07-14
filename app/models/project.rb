class Project < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  include  ActionView::Helpers::SanitizeHelper

  # relations
  has_many :accessorizations, dependent: :destroy, index_errors: true
  has_many :accesses_users, :through => :accessorizations, source: :user
  belongs_to :project_status
  belongs_to :customer

  has_many :attachments, as: :attachmenable

  # validates
  validates :number, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { :case_sensitive => false }

  accepts_nested_attributes_for :accessorizations, reject_if: :all_blank, allow_destroy: true

  def flat_assigned_users
    # 1. Without sort by user.name
    # self.accessorizations.order(:id).flat_map {|row| row.link_assigned_user_as }.join('<br>').html_safe
 
    # 2. With sort by user.name, but OUTER LEFT join.
    #Accessorization.includes(:user, :role).where(project_id: self.id).order("users.name").map {|row| "#{row.user.present? ? row.user.name_as_link : ''} - #{row.role.present? ? row.role.name_as_link : ''}" }.join('<br>').html_safe

    # 3. change {row.user.present? ? row.user.name_as_link : ''}  -> {row.user.try(:name_as_link)}
    Accessorization.includes(:user, :role).where(project_id: self.id).order("users.name").map {|row| "#{row.user.try(:name_as_link)} - #{row.role.try(:name_as_link)}" }.join('<br>').html_safe
  end

  def fullname
    "#{self.number} (#{self.project_status.name})"
  end

  def number_as_link
    "<a href=#{url_helpers.project_path(self)}>#{self.fullname}</a>".html_safe
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

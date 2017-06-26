class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :registerable,
         :recoverable,
         :timeoutable, 
         :trackable, 
         :validatable,
         :lockable

  # relations
  has_and_belongs_to_many :roles

  has_many :accessorizations, dependent: :nullify, index_errors: true
  has_many :accesses_projects, :through => :accessorizations, source: :project

  accepts_nested_attributes_for :accessorizations, reject_if: :all_blank, allow_destroy: true


  def flat_assigned_projects
    #self.accessorizations.order(:id).flat_map {|row| row.assigned_user_as }.join('<br>').html_safe
    Accessorization.includes(:project).where(user_id: self.id).order("projects.number").flat_map {|row| row.link_assigned_project_as }.join('<br>').html_safe
  end

  def fullname
    "#{name} (#{email})"
  end

  # Scope for select2: "user_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "Kow ski@"
  # * result   :
  #   * +scope+ -> collection 
  #
  scope :finder_user, ->(q) { where( create_sql_string("#{q}") ) }

  # Method create SQL query string for finder select2: "user_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "Kow ski@"
  # * result   :
  #   * +sql_string+ -> string for SQL WHERE... 
  #   Eg.: "((users.name ilike '%Kow%' OR users.email ilike '%Kow%' ilike '%Kow%') AND (users.name ilike '%ski@%' OR users.email ilike '%ski@%')"
  #
  def self.create_sql_string(query_str)
    query_str.split.map { |par| one_param_sql(par) }.join(" AND ")
  end

  # Method for glue parameters in create_sql_string
  # * parameters   :
  #   * +one_query_word+ -> word for search. 
  #   Eg.: "Kow"
  # * result   :
  #   * +sql_string+ -> SQL string query for one word 
  #   Eg.: "(users.name ilike '%Kow%' OR users.email ilike '%Kow%')"
  #
  def self.one_param_sql(one_query_word)
    #escaped_query_str = sanitize("%#{query_str}%")
    escaped_query_str = Loofah.fragment("'%#{one_query_word}%'").text
    "(" + %w(users.name users.email).map { |column| "#{column} ilike #{escaped_query_str}" }.join(" OR ") + ")"
  end

end

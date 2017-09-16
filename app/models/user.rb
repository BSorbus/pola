class User < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :confirmable, 
         :recoverable,
         :registerable,
         :timeoutable, 
         :trackable, 
         :validatable,
         :lockable

  # devise  :database_authenticatable, 
  #         :lockable,
  #         :recoverable, 
  #         :registerable, 
  #         :timeoutable, 
  #         :trackable, 
  #         :validatable,
  #           :password_expirable,
  #           :secure_validatable, 
  #           :password_archivable, 
  #           :expirable,
  #         :authentication_keys => [:email]

  # relations
  has_and_belongs_to_many :roles

  has_many :accessorizations, dependent: :nullify, index_errors: true

  has_many :attachments, as: :attachmenable, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :ratings, dependent: :nullify

  accepts_nested_attributes_for :accessorizations, reject_if: :all_blank, allow_destroy: true

  # callbacks
  before_destroy :has_important_links, prepend: true


  def has_important_links
    analize_value = true
    if self.accessorizations.any? 
     errors.add(:base, 'Nie można usunąć konta "' + self.try(:fullname) + '" które jest powiązane z Zadaniami.')
     analize_value = false
    end
    if self.ratings.any? 
     errors.add(:base, 'Nie można usunąć konta "' + self.try(:fullname) + '" które jest powiązane z Ocenami.')
     analize_value = false
    end
    throw :abort unless analize_value 
  end

  def flat_assigned_events 
    Accessorization.includes(:event, :role).where(user_id: self.id).order("events.end_date desc").map {|row| "#{row.event.try(:title_as_link)} - #{row.role.try(:name_as_link)}" }.join('<br>').html_safe
  end

  def flat_assigned_events_with_status 
    Accessorization.joins(event: [:event_status], role: []).where(user_id: self.id).order("events.end_date desc").map {|row| "#{row.event.try(:title_as_link)} - [#{row.event.event_status.name}] - #{row.role.try(:name_as_link)}" }.join('<br>').html_safe
  end

  def fullname
    "#{name} (#{email})"
  end

  def name_as_link
    "<a href=#{url_helpers.user_path(self)}>#{self.name}</a>".html_safe
  end

  # Scope for select2: "user_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "Jan ski@"
  # * result   :
  #   * +scope+ -> collection 
  #
  scope :finder_user, ->(q) { where( create_sql_string("#{q}") ) }

  # Method create SQL query string for finder select2: "user_select"
  # * parameters   :
  #   * +query_str+ -> string for search. 
  #   Eg.: "Jan ski@"
  # * result   :
  #   * +sql_string+ -> string for SQL WHERE... 
  #   Eg.: "((users.name ilike '%Jan%' OR users.email ilike '%Jan%') AND (users.name ilike '%ski@%' OR users.email ilike '%ski@%'))"
  #
  def self.create_sql_string(query_str)
    query_str.split.map { |par| one_param_sql(par) }.join(" AND ")
  end

  # Method for glue parameters in create_sql_string
  # * parameters   :
  #   * +one_query_word+ -> word for search. 
  #   Eg.: "Jan"
  # * result   :
  #   * +sql_string+ -> SQL string query for one word 
  #   Eg.: "(users.name ilike '%Jan%' OR users.email ilike '%Jan%')"
  #
  def self.one_param_sql(one_query_word)
    #escaped_query_str = sanitize("%#{query_str}%")
    escaped_query_str = Loofah.fragment("'%#{one_query_word}%'").text
    "(" + %w(users.name users.email).map { |column| "#{column} ilike #{escaped_query_str}" }.join(" OR ") + ")"
  end

  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end  
  
  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  
  
  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end  

end

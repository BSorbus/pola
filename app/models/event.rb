class Event < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  # relations
  belongs_to :project
  belongs_to :event_status
  belongs_to :event_type
  belongs_to :errand

  has_many :attachments, as: :attachmenable, dependent: :destroy

  has_many :accessorizations, dependent: :destroy, index_errors: true
  has_many :accesses_users, through: :accessorizations, source: :user

  has_many :comments, dependent: :delete_all
  has_many :ratings, dependent: :destroy

  belongs_to :user
  has_many :works, as: :trackable

  # validates
  validates :title, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { scope: [:project_id], :message => " - takie zadanie jest już zdefiniowane w tym projekcie" }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :project_id, presence: true
  validates :errand_id, presence: true


  accepts_nested_attributes_for :accessorizations, reject_if: :all_blank, allow_destroy: true

  # callbacks
  before_create { self.title = "#{title} - #{self.project.number}" }
  after_commit :send_notification, on: [:create, :update]
  before_destroy :has_important_links, prepend: true
  
  after_create_commit { self.log_work_without_check_changed('create') }


  def log_work_without_check_changed(type)
    self.works.create!(trackable_url: "#{url_helpers.event_path(self)}", action: "#{type}", user: self.user, 
      parameters: self.to_json(except: [:user_id, :project_id, :event_status_id, :event_type_id, :errand_id], 
        include: {project: {only: [:id, :number]}, 
                  event_status: {only: [:id, :name]}, 
                  event_type: {only: [:id, :name]}, 
                  errand: {only: [:id, :name]}, 
                  accessorizations: {only: [:id, :event_id], include: {user: {only: [:id, :name, :email]}, role: {only: [:id, :name]}} }, 
                  user: {only: [:id, :name, :email]}}
      )
    )
  end

  def has_important_links
    analize_value = true
    if self.ratings.any? 
     errors.add(:base, 'Nie można usunąć zadania do którego są przypisane Oceny.')
     analize_value = false
    end
    throw :abort unless analize_value 
  end

  def send_notification
    #StatusMailer.new_update_event_email(self).deliver_later if self.accesses_users.any?
  end


  def fullname
    "#{self.title}"
  end

  def flat_assigned_users
    # 1. Without sort by user.name
    # self.accessorizations.order(:id).flat_map {|row| row.link_assigned_user_as }.join('<br>').html_safe
 
    # 2. With sort by user.name, but OUTER LEFT join.
    #Accessorization.includes(:user, :role).where(event_id: self.id).order("users.name").map {|row| "#{row.user.present? ? row.user.name_as_link : ''} - #{row.role.present? ? row.role.name_as_link : ''}" }.join('<br>').html_safe

    # 3. change {row.user.present? ? row.user.name_as_link : ''}  -> {row.user.try(:name_as_link)}
    Accessorization.includes(:user, :role).where(event_id: self.id).order("users.name").map {|row| "#{row.user.try(:name_as_link)} - #{row.role.try(:name_as_link)}" }.join('<br>').html_safe
  end

  def title_as_link
    "<a href=#{url_helpers.event_path(self)}>#{self.fullname}</a>".html_safe
  end

  def color_value
    if self.event_status_id == EventStatus::EVENT_STATUS_CLOSED
      'gray'
    else 
      case (self.end_date.to_date - Time.zone.now.to_date).to_i
      when -99999999..3
        'red'
      when 4..7
        'fuchsia'
      when 8..14
        'orange'
      when 15..30
        'green'
      else 
        ''      
      end
    end
  end

end

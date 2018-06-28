class Event < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  # relations
  belongs_to :user
  belongs_to :project
  belongs_to :event_status
  belongs_to :event_type
  belongs_to :event_effect, optional: true
  belongs_to :errand

  has_many :accessorizations, dependent: :destroy, index_errors: true
  has_many :accesses_users, through: :accessorizations, source: :user

  has_many :comments, dependent: :delete_all

  has_many :attachments, as: :attachmenable, dependent: :destroy
  has_many :works, as: :trackable

  # validates
  validates :title, presence: true,
                    length: { in: 1..100 },
                    :uniqueness => { scope: [:project_id], :message => " - takie zadanie jest już zdefiniowane w tym projekcie" }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :project_id, presence: true
  validates :errand_id, presence: true

  validate :dates_is_correct#, unless: :end_date.empty?

  accepts_nested_attributes_for :accessorizations, reject_if: :all_blank, allow_destroy: true

  # callbacks
  before_create { self.title = "#{title} - #{self.project.number}" }
  
  after_create_commit { self.log_work('create') }
  after_update_commit { self.log_work('update') }


  def self.for_user_in_accessorizations(u)
    eager_load(:accessorizations).where(accessorizations: {user_id: [u]})
  end

  def dates_is_correct
    if end_date.present? && start_date.present? && (end_date < start_date)
      errors.add(:end_date, 'nie może być wcześniejszy niż Początek')
      throw :abort 
    end
  end

  def log_work(action = '', action_user_id = nil)
    trackable_url = (action == 'destroy') ? nil : "#{url_helpers.event_path(self)}"
    worker_id = action_user_id || self.user_id
    Work.create!(trackable_type: 'Event', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
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

  def send_notification_to_pool
    NotificationPoolJob.set(wait: 15.seconds).perform_later(self.class.to_s, self.id)
    #StatusMailer.new_update_event_email(self).deliver_later if self.accesses_users.where(notification_by_email: true).any? || User.joins(:roles).where(users: {notification_by_email: true}).where("'event:create' = ANY (roles.activities)").any?
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

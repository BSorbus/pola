class BusinessTrip < ApplicationRecord
  delegate :url_helpers, to: 'Rails.application.routes'

  # relations
  belongs_to :business_trip_status
  belongs_to :user
  belongs_to :employee, :class_name => 'User'
  belongs_to :business_trip_status_updated_user, :class_name => 'User'
  belongs_to :payment_on_account_approved, :class_name => 'User', required: false

  has_many :flows, dependent: :destroy
  has_many :transports, inverse_of: :business_trip, dependent: :destroy
  has_many :roads, dependent: :destroy

  # validates
  validates :number, presence: true,
                    length: { in: 1..20 },
                    uniqueness: { case_sensitive: false }
  validates :employee_id, presence: true
  validates :business_trip_status_id, presence: true
  validates :business_trip_status_updated_at, presence: true
  validates :business_trip_status_updated_user_id, presence: true
  validates :destination, presence: true,
                    length: { in: 1..150 }
  validates :purpose, presence: true,
                    length: { minimum: 3 }

  validate :end_after_start
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :must_have_transport

  # callbacks
  after_create :save_flow
  after_update :save_flow_if_update_status

  accepts_nested_attributes_for :transports, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :roads, reject_if: :all_blank, allow_destroy: true


  def fullname
    "#{number}"
  end

  def number_as_link
    "<a href=#{url_helpers.business_trip_path(self)}>#{self.number}</a>".html_safe
  end

  def business_trip_status_info
    "<strong>Status</strong>: #{self.business_trip_status.name}, <strong>Zmienił</strong>: #{self.business_trip_status_updated_user.fullname}, #{self.business_trip_status_updated_at.strftime("%Y-%m-%d %H:%M:%S")}".html_safe
  end

  def payment_on_account_approved_enabled?
    self.payment_on_account.to_f > 0.0 && self.payment_on_account_approved_id.blank?
  end

  def business_trip_status_button_enabled?(step)
    self.business_trip_status.previous_step.include?(step) || (self.business_trip_status.step == step) || self.business_trip_status.next_step.include?(step)
  end

  def business_trip_status_left_button_class(button_step)
    if self.business_trip_status.step == button_step
      "btn btn-primary disabled btn-block"
    else
      if self.business_trip_status.previous_step.include?(button_step)
        "btn btn-default btn-block"
      else
        self.business_trip_status.next_step.include?(button_step) ? "btn btn-success btn-block" : "btn btn-default disabled btn-block"
      end  
    end
  end

  def business_trip_status_button_class(button_step)
    if self.business_trip_status.step == button_step
      "btn btn-primary disabled"
    else
      if self.business_trip_status.previous_step.include?(button_step)
        "btn btn-default"
      else
        self.business_trip_status.next_step.include?(button_step) ? "btn btn-success" : "btn btn-default disabled"
      end  
    end
  end

  def business_trip_status_button_icon_span(status_id)
    '<span class="glyphicon glyphicon-ok"></span>'.html_safe if self.flows.pluck(:business_trip_status_id).include?(status_id) 
  end

  def log_work(action = '', action_user_id = nil)
    # trackable_url = (action == 'destroy') ? nil : "#{url_helpers.event_path(self)}"
    # worker_id = action_user_id || self.user_id
    # Work.create!(trackable_type: 'Event', trackable_id: self.id, trackable_url: trackable_url, action: "#{action}", user_id: worker_id, 
    #   parameters: self.to_json(except: [:user_id, :project_id, :event_status_id, :event_type_id, :errand_id], 
    #     include: {project: {only: [:id, :number]}, 
    #               event_status: {only: [:id, :name]}, 
    #               event_type: {only: [:id, :name]}, 
    #               errand: {only: [:id, :name]}, 
    #               accessorizations: {only: [:id, :event_id], include: {user: {only: [:id, :name, :email]}, role: {only: [:id, :name]}} }, 
    #               user: {only: [:id, :name, :email]}}
    #   )
    # )
  end

  private

    def save_flow_if_update_status
      save_flow if saved_change_to_attribute?(:business_trip_status_id)
    end

    def save_flow
      self.flows.create(business_trip_status_id: self.business_trip_status_id, 
        business_trip_status_updated_user_id: self.business_trip_status_updated_user_id,
        business_trip_status_updated_at: self.business_trip_status_updated_at)
    end

    def end_after_start
      return if end_date.blank? || start_date.blank?
     
      if end_date < start_date
        errors.add(:end_date, 'nie może być wcześniejsza od "Na czas od"') 
        throw :abort 
      end 
    end

    def must_have_transport
      errors.add(:transports, '- musi zostać określony przynajmniej jeden') if transports_notvalid?
    end

    def transports_notvalid?
      # ret = false
      # transport_type = []
      # # puts '-----------------------------------------------'
      # # puts transports.collect.as_json
      # # transports.each {|row| puts row.marked_for_destruction? }
      # # puts '-----------------------------------------------'

      # transports.each do |row|
      #   puts '-------------------------------------------------' 
      #   puts row.as_json
      #   puts row.marked_for_destruction?
      #   puts '-------------------------------------------------' 
      #   ret = true unless row.marked_for_destruction? 
      # end unless transports.empty?
      # ret

      transports.empty? or transports.all? {|row| row.marked_for_destruction? }
    end



end

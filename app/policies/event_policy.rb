class EventPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def permitted_attributes
    # if policy(:accessorization).create_update_delete?
    if AccessorizationPolicy.new(@user, :accessorization).create_update_delete?
      [:title, :all_day, :start_date, :end_date, :status, :note, :project_id, :event_type_id, accessorizations_attributes: [:id, :event_id, :user_id, :role_id, :_destroy]]
    else
      [:title, :all_day, :start_date, :end_date, :status, :note, :project_id, :event_type_id]
    end
  end

  def index?
    user_activities.include? 'event:index'
  end

  def show?
    user_activities.include? 'event:show'
  end
 
  def new?
    create?
  end

  def create?
    user_activities.include? 'event:create'
  end

  def edit?
    update?
  end

  def update?
    user_activities.include? 'event:update'
  end

  def destroy?
    user_activities.include? 'event:delete'
  end
 
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
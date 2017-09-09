class RatingPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def event_type_activities
    if @model.class.to_s == 'Symbol'
      EventType.joins(events: {accessorizations: [:user], event_status: []})
        .where(events: {accessorizations: {user_id: [@user]}})
        .merge(EventStatus.status_can_change)
        .select(:activities).distinct.map(&:activities).flatten
    else
      EventType.joins(events: {accessorizations: [:user], event_status: []})
        .where(events: {accessorizations: {user_id: [@user], event_id: [@model.event]}})
        .merge(EventStatus.status_can_change)
        .select(:activities).distinct.map(&:activities).flatten
    end      
    # wybierz activites z events np.;
    # ["project:*", "opinion:*" ]
  end

  def event_user_activities
    if @model.class.to_s == 'Symbol'
      []
    else
      Role.joins(accessorizations: {user:[], event: [:event_status]})
        .where(accessorizations: {user: [@user], event: [@model.event]})
        .merge(EventStatus.status_can_change)
        .select(:activities).distinct.map(&:activities).flatten
    end
    # wybierz activites for user accessorizations from events ex.;
    # ["*:index", "*:show", "*:create", "*:update", "*:delete"]
  end

  def export?
    true
  end

  def index?
    # user_activities.include? 'rating:index'
    (user_activities.include? 'rating:index') || (event_activities(@model).include? 'rating:index')
  end

  def show?
    # user_activities.include? 'rating:show'
    (user_activities.include? 'rating:show') || (event_activities(@model).include? 'rating:show')
  end
 
  def new?
    create?
  end

  def create?
    # user_activities.include? 'rating:create'
    (user_activities.include? 'rating:create') || (event_activities(@model).include? 'rating:create')
  end

  def edit?
    update?
  end

  def update?
    (user_activities.include? 'rating:update') || (event_activities(@model).include? 'rating:update')
  end

  def destroy?
    # user_activities.include? 'rating:delete'
    (user_activities.include? 'rating:delete') || (event_activities(@model).include? 'rating:delete')
  end
 

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end
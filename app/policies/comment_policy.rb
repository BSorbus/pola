class CommentPolicy < ApplicationPolicy
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

  def index?
    # user_activities.include? 'comment:index'
    (user_activities.include? 'comment:index') || (event_activities(@model).include? 'comment:index')
  end

  def show?
    # user_activities.include? 'comment:show'
    (user_activities.include? 'comment:show') || (event_activities(@model).include? 'comment:show')
  end
 
  def new?
    create?
  end

  def create?
    # user_activities.include? 'comment:create'
    (user_activities.include? 'comment:create') || (event_activities(@model).include? 'comment:create')
  end

  def destroy?
    # user_activities.include? 'comment:delete'
    (user_activities.include? 'comment:delete') || (event_activities(@model).include? 'comment:delete')
  end
 

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end